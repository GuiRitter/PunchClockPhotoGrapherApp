import 'package:flutter/material.dart'
    show
        BottomAppBar,
        BuildContext,
        EdgeInsets,
        ElevatedButton,
        SizedBox,
        StatelessWidget,
        Text,
        Theme,
        VoidCallback,
        Widget;

class BottomAppBarWidget extends StatelessWidget {
  final VoidCallback? onButtonPressed;
  final String label;

  const BottomAppBarWidget({
    super.key,
    required this.onButtonPressed,
    required this.label,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final theme = Theme.of(
      context,
    );

    final fieldPadding = theme.textTheme.labelLarge?.fontSize ?? 0.0;

    return BottomAppBar(
      color: theme.scaffoldBackgroundColor,
      padding: EdgeInsets.all(
        fieldPadding,
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onButtonPressed,
          child: Text(
            label,
          ),
        ),
      ),
    );
  }
}
