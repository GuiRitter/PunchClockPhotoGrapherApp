import 'package:flutter/material.dart';

ThemeData light({
  required BuildContext context,
}) =>
    ThemeData.light(
      useMaterial3: false,
    ).copyWith(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: MaterialColor(
          const Color(
            0xFFca9600,
          ).value,
          const {
            50: Color(
              0xFFf7f4de,
            ),
            100: Color(
              0xFFece2ac,
            ),
            200: Color(
              0xFFe0ce76,
            ),
            300: Color(
              0xFFd5bd3d,
            ),
            400: Color(
              0xFFceaf00,
            ),
            500: Color(
              0xFFc9a200,
            ),
            600: Color(
              0xFFca9600,
            ),
            700: Color(
              0xFFcb8600,
            ),
            800: Color(
              0xFFca7600,
            ),
            900: Color(
              0xFFca5800,
            ),
          },
        ),
        accentColor: const Color(
          0xFF376f4e,
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        cardColor: Colors.white,
        errorColor: const Color(
          0xFFB00020,
        ),
      ),
    );
