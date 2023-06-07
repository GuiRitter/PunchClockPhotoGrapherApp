import 'package:flutter/material.dart';

/*
	set date/time and send
year/month/day or picker
hour:minute or picker
save button
back button
*/

class SubmitPage extends StatelessWidget {
  const SubmitPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            title: Column(
              children: [
                Text("Punch Clock Photo Grapher",
                    style: Theme.of(context).textTheme.bodySmall),
                const Text(
                  "Submit",
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {},
                child: const Icon(
                  Icons.send,
                ),
              ),
            ]),
      );
}
