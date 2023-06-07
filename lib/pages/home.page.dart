import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:punch_clock_photo_grapher_mobile/main.dart';
import 'package:punch_clock_photo_grapher_mobile/models/sign_in.dart';
import 'package:punch_clock_photo_grapher_mobile/pages/camera.page.dart';
import 'package:http/http.dart' as http;
import 'package:punch_clock_photo_grapher_mobile/widgets/elevated-button-with-loading.widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  static String? _userId;
  static String? _password;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SharedPreferences.getInstance().then((prefs) {
      var token = prefs.getString("token");
      if ((token != null) && (token.isNotEmpty)) {
        navigate(context, const CameraPage());
      }
    });

    var signInButton = ElevatedButtonWithLoading(
        beforeLoading: () async {
          if ((_formKey.currentState == null) ||
              (!_formKey.currentState!.validate())) {
            return;
          }

          _formKey.currentState!.save();
        },
        duringLoading: (Map<String, dynamic>? beforeData) async {
          var response = await http.post(
            Uri.parse(
              "https://guilherme-alan-ritter.net/punch_clock_photo_grapher/api/user/sign_in",
            ),
            body: SignIn(
              userId: _userId!,
              password: _password!,
            ).toJson(),
          );

          return {"response": response};
        },
        afterLoading: (Map<String, dynamic>? beforeData,
            Map<String, dynamic>? duringData) async {
          var response = duringData!["response"];

          var body = jsonDecode(response.body);

          if (response.statusCode != HttpStatus.ok) {
            var error = body["error"];
            var message = "${error ?? "Unknown error."}";

            if (context.mounted) {
              showSnackBar(context, message);
            }

            return;
          }

          var data = body["data"];
          var token = data["token"];

          var prefs = await SharedPreferences.getInstance();
          await prefs.setString(
            "token",
            token,
          );

          if (context.mounted) {
            navigate(
              context,
              const CameraPage(),
            );
          }
        },
        text: "Sign in");

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Punch Clock Photo Grapher",
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(
            Theme.of(context).textTheme.titleLarge?.fontSize ?? 0,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "User ID",
                  ),
                  keyboardType: TextInputType.text,
                  onSaved: (input) => _userId = input,
                  validator: (value) => ((value == null) || (value.isEmpty))
                      ? "Invalid user ID."
                      : null,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom:
                        Theme.of(context).textTheme.titleLarge?.fontSize ?? 0,
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Password",
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    onSaved: (input) => _password = input,
                    validator: (value) => ((value == null) || (value.isEmpty))
                        ? "Invalid password."
                        : null,
                  ),
                ),
                signInButton,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
