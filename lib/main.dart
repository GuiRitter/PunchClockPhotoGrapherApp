import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:punch_clock_photo_grapher_mobile/blocs/date_time.bloc.dart';
import 'package:punch_clock_photo_grapher_mobile/blocs/user.bloc.dart';
import 'package:punch_clock_photo_grapher_mobile/constants/settings.dart';
import 'package:punch_clock_photo_grapher_mobile/models/date_time_constants.dart';
import 'package:punch_clock_photo_grapher_mobile/pages/tabs.page.dart';

void main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const MyApp(),
  );
}

TimeOfDay? buildTimeOfDay(
  String text,
) {
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

Future<CameraDescription> getCamera() async {
  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.firstWhere(
    (
      wCamera,
    ) =>
        wCamera.lensDirection == CameraLensDirection.back,
  );

  // TODO get macro lens
  // final macroCamera = CameraDescription(
  //   name: "2",
  //   lensDirection: firstCamera.lensDirection,
  //   sensorOrientation: firstCamera.sensorOrientation,
  // );

  return firstCamera;
}

String getISO8601({
  required String date,
  required String time,
}) {
  var dateTime = DateTime.parse(
    "${date}T$time",
  );
  return DateFormat(
    "yyyy-MM-ddTHH:mm:ss${getISO8601TimeZone(
      timeZoneOffsetInMinutes: dateTime.timeZoneOffset.inMinutes,
    )}",
  ).format(
    dateTime,
  );
}

String getISO8601TimeZone({
  required int timeZoneOffsetInMinutes,
}) {
  var hour = timeZoneOffsetInMinutes ~/ 60;
  var minute = timeZoneOffsetInMinutes % 60;

  return "${NumberFormat(
    "+00;-00",
  ).format(
    hour,
  )}:${NumberFormat(
    "00",
  ).format(
    minute,
  )}";
}

String printTimeOfDay({
  required TimeOfDay timeOfDay,
}) =>
    DateFormat(
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

void showSnackBar({
  required String? message,
}) =>
    Settings.snackState.currentState!.showSnackBar(
      SnackBar(
        content: Text(
          message ?? "",
        ),
      ),
    );

String treatDioResponse({
  required dynamic response,
}) {
  if (response!.data is Map) {
    if ((response!.data as Map).containsKey(
      Settings.error,
    )) {
      return response!.data[Settings.error];
    }
  }
  return response!.data.toString();
}

String treatException({
  required dynamic exception,
}) {
  if (exception is DioException) {
    if (exception.response != null) {
      return treatDioResponse(
        response: exception.response,
      );
    } else if (exception.message != null) {
      return exception.message!;
    }
  }
  return exception.toString();
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(
    BuildContext context,
  ) =>
      MultiProvider(
        providers: [
          ChangeNotifierProvider<UserBloc>.value(
            value: UserBloc(),
          ),
          ChangeNotifierProvider<DateTimeBloc>.value(
            value: DateTimeBloc(),
          ),
        ],
        child: MaterialApp(
          title: getTitle(
            context,
          ),
          theme: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.white,
            ),
          ),
          home: const TabsPage(),
          scaffoldMessengerKey: Settings.snackState,
          // flutter gen-l10n
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

  /// Only needed here
  getTitle(context) {
    var a = AppLocalizations.of(
      context,
    );

    return a?.title ?? "";
  }
}
