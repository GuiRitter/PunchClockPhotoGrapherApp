import 'package:punch_clock_photo_grapher_app/models/loggable.model.dart';
import 'package:punch_clock_photo_grapher_app/models/state.model.dart';
import 'package:redux/redux.dart';

class ListModel implements LoggableModel {
  final Set<String> weekList;

  ListModel({
    required List<dynamic> data,
  }) : weekList = data
            .map(
              (
                photo,
              ) =>
                  photo.toString(),
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
        "weekList": weekList.toList(),
      };

  static ListModel? select(
    Store<StateModel> store,
  ) =>
      store.state.list;
}
