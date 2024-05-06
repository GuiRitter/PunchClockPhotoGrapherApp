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
            ,
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
          0xFF6343a8,
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        cardColor: Colors.white,
        errorColor: const Color(
          0xFFB00020,
        ),
      ),
    );
