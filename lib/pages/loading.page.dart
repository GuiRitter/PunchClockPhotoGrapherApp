import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({
    super.key,
  });

  // TODO cancel request

  @override
  Widget build(
    BuildContext context,
  ) =>
      Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              Text(
                "Punch Clock Photo Grapher",
                style: Theme.of(
                  context,
                ).textTheme.bodySmall,
              ),
              const Text(
                "Loading",
              ),
            ],
          ),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
}
