import 'package:flutter/material.dart'
    show
        Alignment,
        ButtonStyle,
        MainAxisAlignment,
        Row,
        Text,
        TextButton,
        Widget;

Widget buildRowForMultiChoice({
  required Widget child,
}) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        child,
      ],
    );

Widget buildTextButton({
  required String label,
  required void Function() onPressed,
  required bool align,
}) =>
    TextButton(
      style: align
          ? const ButtonStyle(
              alignment: Alignment.centerRight,
            )
          : null,
      onPressed: onPressed,
      child: Text(
        label,
      ),
    );
