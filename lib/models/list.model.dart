import 'package:punch_clock_photo_grapher_app/models/loggable.model.dart';
import 'package:punch_clock_photo_grapher_app/models/state.model.dart';
import 'package:punch_clock_photo_grapher_app/models/week.model.dart';
import 'package:redux/redux.dart';

class ListModel implements LoggableModel {
  final Set<WeekModel> weekList;

  ListModel({
    required List<dynamic> data,
  }) : weekList = data
            .map(
              (
                photo,
              ) =>
                  WeekModel(
                data: photo.toString(),
              ),
            )
            .toSet();

  ListModel.empty() : weekList = Set.identity();

  @override
  int get hashCode => weekList.hashCode;

  @override
  bool operator ==(
    Object other,
  ) {
    if (other is! ListModel) return false;

    if (weekList.length != other.weekList.length) return false;

    return weekList.every(
      (
        week,
      ) =>
          other.weekList.contains(
        week,
      ),
    );
  }

  @override
  Map<String, dynamic> asLog() => <String, dynamic>{
        "weekList": weekList
            .toList()
            .map(
              (
                week,
              ) =>
                  week.asLog(),
            )
            .toList(),
      };

  static ListModel? select(
    Store<StateModel> store,
  ) =>
      store.state.list;
}
