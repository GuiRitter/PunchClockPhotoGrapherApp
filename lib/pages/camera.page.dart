import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:punch_clock_photo_grapher_mobile/main.dart';
import 'package:punch_clock_photo_grapher_mobile/pages/home.page.dart';
import 'package:punch_clock_photo_grapher_mobile/pages/submit.page.dart';
import 'package:http/http.dart' as http;
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

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) => Scaffold(
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
            TextButton(
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Icon(
                      Icons.api,
                    ),
              onPressed: () async {
                if (_isLoading) {
                  return;
                }

                var prefs = await SharedPreferences.getInstance();
                var token = prefs.getString(
                  "token",
                );

                if ((token == null) || (token.isEmpty)) {
                  if (context.mounted) {
                    showSnackBar(context, "Token not found.");
                    navigate(
                      context,
                      const HomePage(),
                    );
                  }
                  return;
                }

                setState(() {
                  _isLoading = true;
                });

                var response = await http.get(
                  Uri.parse(
                    "https://guilherme-alan-ritter.net/punch_clock_photo_grapher/api/photo/",
                  ),
                  headers: {
                    "token": token,
                  },
                );

                setState(() {
                  _isLoading = false;
                });

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
                      const HomePage(),
                    );
                  }
                }
              },
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
      );
}
