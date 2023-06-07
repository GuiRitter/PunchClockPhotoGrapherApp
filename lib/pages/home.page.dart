import 'package:flutter/material.dart';
import 'package:punch_clock_photo_grapher_mobile/pages/camera.page.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: "User ID",
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: "Password",
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CameraPage(),
                    ),
                  ),
                  child: const Text(
                    "Sign in",
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
