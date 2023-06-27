import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:punch_clock_photo_grapher_mobile/blocs/date_time.bloc.dart';
import 'package:punch_clock_photo_grapher_mobile/blocs/user.bloc.dart';
import 'package:punch_clock_photo_grapher_mobile/constants/result_status.dart';
import 'package:punch_clock_photo_grapher_mobile/main.dart';
import 'package:punch_clock_photo_grapher_mobile/models/date_time_constants.dart';

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

    var l10n = AppLocalizations.of(context)!;

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
              AppLocalizations.of(
                context,
              )!
                  .title,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              l10n.submit,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => onSendPressed(
              context: context,
              imageFile: imageFile,
            ),
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

  onBackPressed(
    BuildContext context,
  ) {
    final userBloc = Provider.of<UserBloc>(
      context,
      listen: false,
    );
    userBloc.photoPath = null;
  }

  onSendPressed({
    required BuildContext context,
    required File imageFile,
  }) async {
    final userBloc = Provider.of<UserBloc>(
      context,
      listen: false,
    );

    final result = await userBloc.submitPhoto(
      context: context,
      imageBytes: imageFile.readAsBytesSync(),
    );

    if (result.status == ResultStatus.success) {
      userBloc.photoPath = null;
    } else {
      showSnackBar(
        message: result.message,
      );
    }
  }
}
