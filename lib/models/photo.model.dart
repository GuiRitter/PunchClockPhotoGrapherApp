import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show LoggableModel, StateModel;
import 'package:punch_clock_photo_grapher_app/utils/date_time.dart'
    show getISO8601Date, getISO8601Time;
import 'package:redux/redux.dart' show Store;

class PhotoModel implements LoggableModel {
  final String date;
  final String time;

  PhotoModel({
    required this.date,
    required this.time,
  });

  @override
  int get hashCode => Object.hash(
        date,
        time,
      );

  @override
  bool operator ==(
    Object other,
  ) {
    if (other is! PhotoModel) {
      return false;
    }
    return (date.compareTo(other.date) == 0) &&
        (time.compareTo(other.time) == 0);
  }

  @override
  Map<String, dynamic> asLog() => <String, dynamic>{
        'date': date,
        'time': time,
      };

  static PhotoModel select(
    Store<StateModel> store,
  ) =>
      PhotoModel(
        date: getISO8601Date(
          dateTime: store.state.date,
        )!,
        time: getISO8601Time(
          timeOfDay: store.state.time,
        )!,
      );
}
