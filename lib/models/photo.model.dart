import 'package:flutter/material.dart' show TimeOfDay;
import 'package:image_picker/image_picker.dart' show XFile;
import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show LoggableModel, StateModel;
import 'package:punch_clock_photo_grapher_app/utils/date_time.dart'
    show getISO8601Date, getISO8601Time;
import 'package:punch_clock_photo_grapher_app/utils/logger.dart'
    show getExistsMark;
import 'package:redux/redux.dart' show Store;

class PhotoModel implements LoggableModel {
  final DateTime date;
  final TimeOfDay time;
  final XFile? photoFile;

  PhotoModel({
    required this.date,
    required this.time,
    required this.photoFile,
  });

  String get dateString => getISO8601Date(
        dateTime: date,
      )!;

  @override
  int get hashCode => Object.hash(
        date,
        time,
        photoFile,
      );

  String get timeString => getISO8601Time(
        timeOfDay: time,
      )!;

  @override
  bool operator ==(
    Object other,
  ) {
    if (other is! PhotoModel) {
      return false;
    }
    return (date.compareTo(other.date) == 0) &&
        (time == other.time) &&
        (photoFile.hashCode == other.photoFile.hashCode);
  }

  @override
  Map<String, dynamic> asLog() => <String, dynamic>{
        'date': date,
        'time': time,
        'photoFile': getExistsMark(
          photoFile,
        ),
      };

  static PhotoModel select(
    Store<StateModel> store,
  ) =>
      PhotoModel(
        date: store.state.date,
        time: store.state.time,
        photoFile: store.state.photoFile,
      );
}
