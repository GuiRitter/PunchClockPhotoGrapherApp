import 'package:punch_clock_photo_grapher_app/models/loggable.model.dart';

class WeekModel implements LoggableModel {
  final String data;

  WeekModel({
    required this.data,
  });

  @override
  int get hashCode => data.hashCode;

  @override
  bool operator ==(
    Object other,
  ) {
    if (other is! WeekModel) return false;

    return data.compareTo(
          other.data,
        ) ==
        0;
  }

  @override
  Map<String, dynamic> asLog() => <String, dynamic>{
        "data": data,
      };
}
