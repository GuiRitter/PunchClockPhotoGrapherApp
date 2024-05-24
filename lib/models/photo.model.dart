import 'dart:typed_data' show Uint8List;

import 'package:flutter/material.dart' show TimeOfDay;
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
  final Uint8List? photoBytes;

  PhotoModel({
    required this.date,
    required this.time,
    required this.photoBytes,
  });

  String get dateString => getISO8601Date(
        dateTime: date,
      )!;

  @override
  int get hashCode => Object.hash(
        date,
        time,
        photoBytes,
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
        (photoBytes.hashCode == other.photoBytes.hashCode);
  }

  @override
  Map<String, dynamic> asLog() => <String, dynamic>{
        'date': date,
        'time': time,
        'photoFile': getExistsMark(
          photoBytes,
        ),
      };

  static PhotoModel select(
    Store<StateModel> store,
  ) =>
      PhotoModel(
        date: store.state.date,
        time: store.state.time,
        photoBytes: store.state.photoBytes,
      );
}
