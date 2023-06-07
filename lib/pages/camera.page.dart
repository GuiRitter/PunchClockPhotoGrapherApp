import 'package:flutter/material.dart';
import 'package:punch_clock_photo_grapher_mobile/pages/submit.page.dart';

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
              onPressed: () {},
              child: const Icon(
                Icons.api,
              ),
            ),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SubmitPage(),
                ),
              ),
              child: const Icon(
                Icons.navigate_next,
              ),
            ),
          ],
        ),
      );
}
