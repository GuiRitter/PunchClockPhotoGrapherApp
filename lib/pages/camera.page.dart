import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:punch_clock_photo_grapher_mobile/main.dart';
import 'package:punch_clock_photo_grapher_mobile/models/on_pressed_step_data.dart';
import 'package:punch_clock_photo_grapher_mobile/pages/home.page.dart';
import 'package:punch_clock_photo_grapher_mobile/pages/submit.page.dart';
import 'package:http/http.dart' as http;
import 'package:punch_clock_photo_grapher_mobile/widgets/button-with-loading.widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CameraPage extends StatefulWidget {
  final CameraDescription camera;

  const CameraPage({
    super.key,
    required this.camera,
  });

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late String? photoPath;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.low,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();

    photoPath = null;
  }

  @override
  void dispose() {
    photoPath = null;

    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Column(
              children: [
                Text("Punch Clock Photo Grapher",
                    style: Theme.of(context).textTheme.bodySmall),
                const Text(
                  "Camera",
                ),
              ],
            ),
            actions: [
              ButtonWithLoading(
                buttonBuilder: ({
                  required VoidCallback onPressed,
                  required Widget child,
                }) =>
                    TextButton(
                  onPressed: onPressed,
                  child: child,
                ),
                loadingIndicator: const CircularProgressIndicator(),
                beforeLoading: () async {
                  var prefs = await SharedPreferences.getInstance();
                  var token = prefs.getString(
                    "token",
                  );

                  if ((token == null) || (token.isEmpty)) {
                    if (context.mounted) {
                      showSnackBar(context, "Token not found.");
                      navigate(
                        context,
                        HomePage(),
                      );
                    }
                    return OnPressedStepData(shouldContinue: false);
                  }

                  return OnPressedStepData(
                    data: {"token": token},
                    shouldContinue: true,
                  );
                },
                duringLoading: (OnPressedStepData beforeData) async {
                  var token = beforeData.data!["token"];

                  var response = await http.get(
                    Uri.parse(
                      "https://guilherme-alan-ritter.net/punch_clock_photo_grapher/api/photo/",
                    ),
                    headers: {
                      "token": token,
                    },
                  );

                  return OnPressedStepData(
                    data: {"response": response},
                    shouldContinue: true,
                  );
                },
                afterLoading: (OnPressedStepData beforeData,
                    OnPressedStepData duringData) async {
                  var response = duringData.data!["response"];

                  var body = jsonDecode(response.body);

                  if (response.statusCode == HttpStatus.ok) {
                    if (context.mounted) {
                      showSnackBar(context, response.body);
                    }
                  } else {
                    var error = body["error"];
                    var message = "${error ?? "Unknown error."}";

                    if (context.mounted) {
                      showSnackBar(context, message);
                      navigate(
                        context,
                        HomePage(),
                      );
                    }
                  }
                },
                child: const Icon(
                  Icons.api,
                ),
              ),
              TextButton(
                child: const Icon(
                  Icons.navigate_next,
                ),
                onPressed: () {
                  if ((photoPath == null) || (photoPath!.isEmpty)) {
                    return;
                  }

                  navigate(
                    context,
                    SubmitPage(
                      photoPath: photoPath,
                    ),
                  );

                  setState(
                    () => photoPath = null,
                  );
                },
              ),
            ],
          ),
          body: GestureDetector(
            onTap: () async {
              // Take the Picture in a try / catch block. If anything goes wrong,
              // catch the error.
              try {
                // Ensure that the camera is initialized.
                await _initializeControllerFuture;

                // Attempt to take a picture and then get the location
                // where the image file is saved.
                final image = await _controller.takePicture();
                final path = image.path;

                setState(
                  () => photoPath = path,
                );
              } catch (e) {
                // If an error occurs, log the error to the console.
                showSnackBar(
                  context,
                  e.toString(),
                );
              }
            },
            child: Column(
              children: [
                Expanded(
                  // You must wait until the controller is initialized before displaying the
                  // camera preview. Use a FutureBuilder to display a loading spinner until the
                  // controller has finished initializing.
                  child: Center(
                    child: FutureBuilder<void>(
                      future: _initializeControllerFuture,
                      builder: (
                        context,
                        snapshot,
                      ) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          // If the Future is complete, display the preview.
                          return CameraPreview(
                            _controller,
                          );
                        } else {
                          // Otherwise, display a loading indicator.
                          return SizedBox(
                            width: Theme.of(context)
                                    .textTheme
                                    .displayLarge
                                    ?.fontSize ??
                                0,
                            height: Theme.of(context)
                                    .textTheme
                                    .displayLarge
                                    ?.fontSize ??
                                0,
                            child: const CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: ((photoPath != null) && (photoPath!.isNotEmpty))
                        ? Image.file(
                            File(
                              photoPath!,
                            ),
                          )
                        : const Text(
                            "Waiting for photo",
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
        onWillPop: () async {
          var prefs = await SharedPreferences.getInstance();
          prefs.setString("token", "");

          return true;
        },
      );
}
