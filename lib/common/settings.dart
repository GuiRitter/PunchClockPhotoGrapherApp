import 'package:flutter/material.dart';
import 'package:punch_clock_photo_grapher_app/services/dio/dio_for_any.interface.dart';

const apiUrl = "$protocol://$domain$port/$path/";

const appName = "punch_clock_photo_grapher";

const dataKey = "data";

// const domain = "guilherme-alan-ritter.net";
// const domain = "localhost";
// const domain = "127.0.0.1";
const domain = "10.0.2.2";

const errorKey = "error";

const path = "$appName/api";

// const port = "";
const port = ":49235";

// const protocol = "https";
const protocol = "http";

const revalidateToken = "REVALIDATE_TOKEN";

const themeKey = "theme";

const tokenKey = "token";

final api = DioForAny();

final navigatorState = GlobalKey<NavigatorState>();

final snackState = GlobalKey<ScaffoldMessengerState>();
