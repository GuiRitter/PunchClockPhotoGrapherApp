import 'package:flutter/material.dart';
import 'package:punch_clock_photo_grapher_mobile_bloc/models/date_time_constants.dart';

class DateTimeBloc extends ChangeNotifier {
  String _date = DateTimeConstants.nowDate;
  String _time = DateTimeConstants.nowTime;

  String get date => _date;

  set date(
    String newDate,
  ) {
    _date = newDate;
    notifyListeners();
  }

  String get time => _time;

  set time(
    String newTime,
  ) {
    _time = newTime;
    notifyListeners();
  }

  init() {
    _date = DateTimeConstants.nowDate;
    _time = DateTimeConstants.nowTime;
  }

  setDate({
    required String newDate,
    bool isNotify = true,
  }) {
    _date = newDate;
    if (isNotify) {
      notifyListeners();
    }
  }

  setTime({
    required String newTime,
    bool isNotify = true,
  }) {
    _time = newTime;
    if (isNotify) {
      notifyListeners();
    }
  }
}
