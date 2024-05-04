import 'package:flutter/material.dart';
import 'package:punch_clock_photo_grapher_app/ui/widgets/app_bar_signed_in.widget.dart';
import 'package:punch_clock_photo_grapher_app/ui/widgets/body.widget.dart';
import 'package:punch_clock_photo_grapher_app/utils/logger.dart';

final _log = logger("HomePage");

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    _log("build").print();

    return const BodyWidget(
      appBar: AppBarSignedInWidget(),
      body: Text(
        "Hello, World!",
      ),
    );
  }
}
