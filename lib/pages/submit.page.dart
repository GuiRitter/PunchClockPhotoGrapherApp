import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:punch_clock_photo_grapher_mobile_bloc/blocs/date_time.bloc.dart';
import 'package:punch_clock_photo_grapher_mobile_bloc/blocs/user.bloc.dart';
import 'package:punch_clock_photo_grapher_mobile_bloc/main.dart';
import 'package:punch_clock_photo_grapher_mobile_bloc/models/date_time_constants.dart';

class SubmitPage extends StatelessWidget {
  const SubmitPage({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final userBloc = Provider.of<UserBloc>(
      context,
    );
    final dateTimeBloc = Provider.of<DateTimeBloc>(
      context,
    );

    var imageFile = File(
      userBloc.photoPath!,
    );

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => onBackPressed(
            context,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
            onPressed: onSendPressed,
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
                        dateTimeBloc.date,
                      ),
                      firstDate: DateTimeConstants.min,
                      lastDate: DateTimeConstants.max,
                    );

                    if (date != null) {
                      dateTimeBloc.date = DateFormat(
                        DateTimeConstants.dateFormat,
                      ).format(
                        date,
                      );
                    }
                  },
                  child: Text(
                    dateTimeBloc.date,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: buildTimeOfDay(
                            dateTimeBloc.time,
                          ) ??
                          TimeOfDay.now(),
                    );

                    if (time != null) {
                      dateTimeBloc.time = printTimeOfDay(
                        timeOfDay: time,
                      );
                    }
                  },
                  child: Text(
                    "T${dateTimeBloc.time}",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onSendPressed() {
    // TODO
  }

  onBackPressed(
    BuildContext context,
  ) {
    final userBloc = Provider.of<UserBloc>(
      context,
      listen: false,
    );
    userBloc.photoPath = null;
  }
}
