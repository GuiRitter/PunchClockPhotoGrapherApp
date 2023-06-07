import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:punch_clock_photo_grapher_mobile/models/sign_in.dart';
import 'package:punch_clock_photo_grapher_mobile/pages/camera.page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _userId;
  String? _password;

  var _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => Scaffold(
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
                  _isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () async {
                            if ((_formKey.currentState == null) ||
                                (!_formKey.currentState!.validate())) {
                              return;
                            }

                            _formKey.currentState!.save();

                            setState(() {
                              _isLoading = true;
                            });

                            var response = await http.post(
                              Uri.parse(
                                "https://guilherme-alan-ritter.net/punch_clock_photo_grapher/api/user/sign_in",
                              ),
                              body: SignIn(
                                userId: _userId!,
                                password: _password!,
                              ).toJson(),
                            );

                            setState(() {
                              _isLoading = false;
                            });

                            var body = jsonDecode(response.body);

                            if (response.statusCode != HttpStatus.ok) {
                              var error = body["error"];
                              var message = "${error ?? "Unknown error."}";

                              if (context.mounted) {
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      message,
                                    ),
                                  ),
                                );
                              }

                              return;
                            }

                            var data = body["data"];
                            var token = data["token"];

                            var prefs = await SharedPreferences.getInstance();
                            await prefs.setString('token', token);

                            if (context.mounted) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CameraPage(),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            "Sign in",
                          ),
                        )
                ],
              ),
            ),
          ),
        ),
      );
}
