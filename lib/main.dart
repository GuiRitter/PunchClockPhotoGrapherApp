import 'package:flutter/material.dart';
import 'package:punch_clock_photo_grapher_mobile/pages/home.page.dart';

void showSnackBar(BuildContext context, String message) => ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
      ),
    );

void navigate(BuildContext context, Widget widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Punch Clock Photo Grapher',
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}
