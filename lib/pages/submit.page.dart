import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:punch_clock_photo_grapher_mobile/main.dart';
import 'package:punch_clock_photo_grapher_mobile/models/date_time_constants.dart';

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
  Widget build(BuildContext context) {
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
          TextButton(
            onPressed: () {},
            child: const Icon(
              Icons.send,
            ),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                Image.file(
                  File(
                    widget.photoPath!,
                  ),
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
