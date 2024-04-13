import 'package:flutter/material.dart';
import 'package:punch_clock_photo_grapher_app/services/dio/dio_for_any.interface.dart';

const apiUrl =
    "https://guilherme-alan-ritter.net/punch_clock_photo_grapher/api/";

const appName = "punch_clock_photo_grapher";

const data = "data";

const domain = "guilherme-alan-ritter.net";

const error = "error";

const themeKey = "theme";

const token = "token";

final api = DioForAny();

final navigatorState = GlobalKey<NavigatorState>();

final snackState = GlobalKey<ScaffoldMessengerState>();
