import 'package:flutter/material.dart';

ThemeData dark({
  required BuildContext context,
}) =>
    ThemeData.dark(
      useMaterial3: false,
    ).copyWith(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: MaterialColor(
          const Color(
            0xFFca5800,
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
          0xFF7688e0,
        ),
        backgroundColor: const Color(
          0xFF121212,
        ),
        brightness: Brightness.dark,
        cardColor: const Color(
          0xFF121212,
        ),
        errorColor: const Color(
          0xFFCF6679,
        ),
      ),
      appBarTheme: const AppBarTheme(
        color: Color(
          0xFFca5800,
        ),
      ),
    );
