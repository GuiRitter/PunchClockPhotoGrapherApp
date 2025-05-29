import 'dart:typed_data' show Uint8List;

import 'package:flutter_guiritter/extension/_import.dart'
    show DateTimeNullableExtension;
import 'package:flutter_guiritter/model/_import.dart' show LoggableModel;
import 'package:flutter_guiritter/util/_import.dart' show getExistsMark;
import 'package:punch_clock_photo_grapher_app/model/_import.dart'
    show StateModelWrapper;
import 'package:redux/redux.dart' show Store;

class PhotoModel implements LoggableModel {
  final DateTime dateTime;
  final Uint8List? photoBytes;

  PhotoModel({
    required this.dateTime,
    required this.photoBytes,
  });

  String get dateString => dateTime.getISO8601Date()!;

  @override
  int get hashCode => Object.hash(
        dateString,
        photoBytes,
      );

  String get timeString => dateTime.getISO8601Time()!;

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
    Store<Map<String, dynamic>> store,
  ) {
    final state = StateModelWrapper(
      storeStateMap: store.state,
    );

    return PhotoModel(
      dateTime: state.dateTime,
      photoBytes: state.photoByteList,
    );
  }
}
