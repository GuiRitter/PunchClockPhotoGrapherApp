import 'package:flutter/material.dart';

class BodyWidget extends StatelessWidget {
  final PreferredSizeWidget appBar;
  final Widget body;

  const BodyWidget({
    super.key,
    required this.appBar,
    required this.body,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final theme = Theme.of(
      context,
    );

    final fieldPadding = theme.textTheme.labelLarge?.fontSize ?? 0.0;

    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: EdgeInsets.all(
          fieldPadding,
        ),
        child: Center(
          child: body,
        ),
      ),
    );
  }
}
