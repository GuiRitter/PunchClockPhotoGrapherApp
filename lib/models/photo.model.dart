import 'dart:typed_data' show Uint8List;

import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show LoggableModel, StateModel;
import 'package:punch_clock_photo_grapher_app/utils/logger.dart'
    show getExistsMark;
import 'package:punch_clock_photo_grapher_app/utils/utils.import.dart'
    show getISO8601Date, getISO8601TimeFromDateTime;
import 'package:redux/redux.dart' show Store;

class PhotoModel implements LoggableModel {
  final DateTime dateTime;
  final Uint8List? photoBytes;

  PhotoModel({
    required this.dateTime,
    required this.photoBytes,
  });

  String get dateString => getISO8601Date(
        dateTime: dateTime,
      )!;

  @override
  int get hashCode => Object.hash(
        dateString,
        photoBytes,
      );

  String get timeString => getISO8601TimeFromDateTime(
        dateTime: dateTime,
      )!;

  @override
  bool operator ==(
    Object other,
  ) {
    if (other is! PhotoModel) {
      return false;
    }
    return (dateTime.compareTo(other.dateTime) == 0) &&
        (photoBytes.hashCode == other.photoBytes.hashCode);
  }

  @override
  Map<String, dynamic> asLog() => <String, dynamic>{
        'dateTime': dateTime,
        'photoFile': getExistsMark(
          photoBytes,
        ),
      };

  static PhotoModel select(
    Store<StateModel> store,
  ) =>
      PhotoModel(
        dateTime: store.state.dateTime,
        photoBytes: store.state.photoBytes,
      );
}
