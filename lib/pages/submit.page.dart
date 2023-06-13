import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:punch_clock_photo_grapher_mobile/main.dart';
import 'package:punch_clock_photo_grapher_mobile/models/date_time_constants.dart';
import 'package:punch_clock_photo_grapher_mobile/models/on_pressed_step_data.dart';
import 'package:punch_clock_photo_grapher_mobile/models/post_photo.dart';
import 'package:punch_clock_photo_grapher_mobile/models/system_constants.dart';
import 'package:punch_clock_photo_grapher_mobile/widgets/button-with-loading.widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

/*
	set date/time and send
year/month/day or picker
hour:minute or picker
save button
back button
*/

class SubmitPage extends StatefulWidget {
  const SubmitPage({
    super.key,
    required this.photoPath,
  });

  final String? photoPath;

  @override
  State<SubmitPage> createState() => _SubmitPageState();
}

class _SubmitPageState extends State<SubmitPage> {
  late String _date = DateFormat(
    DateTimeConstants.dateFormat,
  ).format(
    DateTime.now(),
  );

  late String _time = DateFormat(
    DateTimeConstants.timeFormat,
  ).format(
    DateTime.now(),
  );

  @override
  Widget build(
    BuildContext context,
  ) {
    var imageFile = File(
      widget.photoPath!,
    );

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              "Punch Clock Photo Grapher",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const Text(
              "Submit",
            ),
          ],
        ),
        actions: [
          ButtonWithLoading(
            buttonBuilder: ({
              required VoidCallback onPressed,
              required Widget child,
            }) =>
                TextButton(
              onPressed: onPressed,
              child: child,
            ),
            loadingIndicator: const CircularProgressIndicator(),
            beforeLoading: () async {
              var prefs = await SharedPreferences.getInstance();
              var token = prefs.getString(
                SystemConstants.token,
              );

              if ((token == null) || (token.isEmpty)) {
                if (context.mounted) {
                  showSnackBar(
                    context,
                    "Token not found.",
                  );
                  navigate(
                    context,
                    null,
                  );
                }
                return OnPressedStepData(
                  shouldContinue: false,
                );
              }

              return OnPressedStepData(
                data: {
                  SystemConstants.token: token,
                },
                shouldContinue: true,
              );
            },
            duringLoading: (
              OnPressedStepData beforeData,
            ) async {
              var imageBytes = imageFile.readAsBytesSync();
              var base64Image = base64Encode(
                imageBytes,
              );

              var dateTime = getISO8601(
                _date,
                _time,
              );

              var token = beforeData.data![SystemConstants.token];

              var response = await http.post(
                Uri.parse(
                  "https://guilherme-alan-ritter.net/punch_clock_photo_grapher/api/photo/",
                ),
                body: PostPhoto(
                  dateTime: dateTime,
                  dataURI: "data:image/png;base64,$base64Image",
                ).toJson(),
                headers: {
                  SystemConstants.token: token,
                },
              );

              return OnPressedStepData(
                data: {
                  "response": response,
                },
                shouldContinue: true,
              );
            },
            afterLoading: (
              OnPressedStepData beforeData,
              OnPressedStepData duringData,
            ) async {
              var response = duringData.data!["response"];

              var body = jsonDecode(
                response.body,
              );

              if (response.statusCode == HttpStatus.ok) {
                if (context.mounted) {
                  navigate(
                    context,
                    null,
                  );
                }
              } else {
                var error = body["error"];
                var message = "${error ?? "Unknown error."}";

                if (context.mounted) {
                  showSnackBar(
                    context,
                    message,
                  );
                }
              }
            },
            child: const Icon(
              Icons.send,
            ),
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                Image.file(
                  imageFile,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.parse(
                        _date,
                      ),
                      firstDate: DateTimeConstants.min,
                      lastDate: DateTimeConstants.max,
                    );

                    if (date != null) {
                      setState(() {
                        _date = DateFormat(
                          DateTimeConstants.dateFormat,
                        ).format(date);
                      });
                    }
                  },
                  child: Text(
                    _date,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: buildTimeOfDay(
                            _time,
                          ) ??
                          TimeOfDay.now(),
                    );

                    if (time != null) {
                      setState(() {
                        _time = printTimeOfDay(
                          time,
                        );
                      });
                    }
                  },
                  child: Text(
                    "T$_time",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
