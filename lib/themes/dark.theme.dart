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
            0xFFEAE659, // WebAIM: 424242 background, this foreground
          ).value,
          const {
            50: Color(
              0xFFfffff0,
            ),
            100: Color(
              0xFFfcfcd1,
            ),
            200: Color(
              0xFFf8f9ac,
            ),
            300: Color(
              0xFFf5f589,
            ),
            400: Color(
              0xFFf0f16e,
            ),
            500: Color(
              0xFFeced53,
            ),
            600: Color(
              0xFFeae659,
            ),
            700: Color(
              0xFFdad354,
            ),
            800: Color(
              0xFFc8bb4c,
            ),
            900: Color(
              0xFFa8943f,
            ),
          },
        ),
        accentColor: const Color(
          0xFFf0f0ff,
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
          0xFFa8943f, // WebAIM: this background, white foreground
        ),
      ),
    );
