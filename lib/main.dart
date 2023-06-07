import 'package:flutter/material.dart';
import 'package:punch_clock_photo_grapher_mobile/pages/home.page.dart';

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
