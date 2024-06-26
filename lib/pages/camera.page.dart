import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:punch_clock_photo_grapher_mobile/blocs/user.bloc.dart';
import 'package:punch_clock_photo_grapher_mobile/constants/result_status.dart';
import 'package:punch_clock_photo_grapher_mobile/main.dart';

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
  Widget build(
    BuildContext context,
  ) {
    var l10n = AppLocalizations.of(
      context,
    )!;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: onBackPressed,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.title,
              style: Theme.of(
                context,
              ).textTheme.bodySmall,
            ),
            Text(
              l10n.camera,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: onApiTestPressed,
            child: Icon(
              Icons.api,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
          TextButton(
            onPressed: onSubmitPressed,
            child: Icon(
              Icons.navigate_next,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: onCameraTapped,
        child: Column(
          children: [
            Expanded(
              // You must wait until the controller is initialized before displaying the
              // camera preview. Use a FutureBuilder to display a loading spinner until the
              // controller has finished initializing.
              child: Center(
                child: FutureBuilder<void>(
                  future: _initializeControllerFuture,
                  builder: buildCamera,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: (photoPath?.isNotEmpty ?? false)
                    ? Image.file(
                        File(
                          photoPath!,
                        ),
                      )
                    : Text(
                        l10n.waitingForPhoto,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCamera(
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
        width: Theme.of(
              context,
            ).textTheme.displayLarge?.fontSize ??
            0,
        height: Theme.of(
              context,
            ).textTheme.displayLarge?.fontSize ??
            0,
        child: const CircularProgressIndicator(),
      );
    }
  }

  @override
  void dispose() async {
    photoPath = null;

    // FIXME _CameraPageState.dispose failed to call super.dispose. dispose() implementations must always call their superclass dispose() method, to ensure that all the resources used by the widget are fully released.
    // Dispose of the controller when the widget is disposed.
    await _controller.dispose();
    super.dispose();
  }

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

  onApiTestPressed() async {
    final bloc = Provider.of<UserBloc>(
      context,
      listen: false,
    );

    final response = await bloc.validateAndSetToken(
      revalidate: true,
    );

    showSnackBar(
      message: (response.status == ResultStatus.success)
          ? response.data
          : response.message,
    );
  }

  onBackPressed() {
    final bloc = Provider.of<UserBloc>(
      context,
      listen: false,
    );

    bloc.validateAndSetToken(
      newToken: null,
    );
  }

  onCameraTapped() async {
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
        message: e.toString(),
      );
    }
  }

  onSubmitPressed() {
    final userBloc = Provider.of<UserBloc>(
      context,
      listen: false,
    );

    userBloc.setUpSubmit(
      context: context,
      photoPath: photoPath,
    );
  }
}
