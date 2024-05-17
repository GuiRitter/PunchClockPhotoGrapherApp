import 'package:flutter/material.dart'
    show
        BuildContext,
        Center,
        EdgeInsets,
        Padding,
        PreferredSizeWidget,
        Scaffold,
        StatelessWidget,
        Theme,
        Widget;

class BodyWidget extends StatelessWidget {
  final PreferredSizeWidget appBar;
  final Widget body;
  final bool usePadding;

  const BodyWidget({
    super.key,
    required this.appBar,
    required this.body,
    this.usePadding = true,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final theme = Theme.of(
      context,
    );

    final fieldPadding = theme.textTheme.labelLarge?.fontSize ?? 0.0;

    Widget child = Center(
      child: body,
    );

    if (usePadding) {
      child = Padding(
        padding: EdgeInsets.all(
          fieldPadding,
        ),
        child: child,
      );
    }

    return Scaffold(
      appBar: appBar,
      body: child,
    );
  }
}
