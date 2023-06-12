import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:punch_clock_photo_grapher_mobile/models/date_time_constants.dart';
import 'package:punch_clock_photo_grapher_mobile/pages/home.page.dart';

void showSnackBar(BuildContext context, String? message) =>
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      SnackBar(
        content: Text(
          message ?? "",
        ),
      ),
    );

void navigate(BuildContext context, Widget widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

Future<CameraDescription> getCamera() async {
  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.firstWhere(
    (wCamera) => wCamera.lensDirection == CameraLensDirection.back,
  );

  // final macroCamera = CameraDescription(
  //   name: "2",
  //   lensDirection: firstCamera.lensDirection,
  //   sensorOrientation: firstCamera.sensorOrientation,
  // );

  return firstCamera;
}

TimeOfDay? buildTimeOfDay(String text) {
  RegExpMatch? match = DateTimeConstants.hourMinuteRegex.firstMatch(
    text,
  );
  if ((match == null) ||
      (match.groupCount != 2) ||
      (match[1] == null) ||
      (match[2] == null)) {
    return null;
  }
  return TimeOfDay(
    hour: int.parse(
      match[1]!,
    ),
    minute: int.parse(
      match[2]!,
    ),
  );
}

String printTimeOfDay(TimeOfDay timeOfDay) => DateFormat(
      DateTimeConstants.timeFormat,
    ).format(
      DateTime(
        DateTimeConstants.min.year,
        DateTimeConstants.min.month,
        DateTimeConstants.min.day,
        timeOfDay.hour,
        timeOfDay.minute,
      ),
    );

void main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Punch Clock Photo Grapher',
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}
