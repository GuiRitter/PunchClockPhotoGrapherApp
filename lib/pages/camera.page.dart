import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:punch_clock_photo_grapher_mobile/main.dart';
import 'package:punch_clock_photo_grapher_mobile/models/on_pressed_step_data.dart';
import 'package:punch_clock_photo_grapher_mobile/pages/home.page.dart';
import 'package:punch_clock_photo_grapher_mobile/pages/submit.page.dart';
import 'package:http/http.dart' as http;
import 'package:punch_clock_photo_grapher_mobile/widgets/button-with-loading.widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
	take photo and preview
test token button
camera
take photo button? or tap canvas
preview
next button? or tap image
sign out button
*/

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

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
                onPressed: () => navigate(
                  context,
                  const SubmitPage(),
                ),
              ),
            ],
          ),
        ),
        onWillPop: () async {
          var prefs = await SharedPreferences.getInstance();
          prefs.setString("token", "");

          return true;
        },
      );
}
