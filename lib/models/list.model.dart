import 'package:punch_clock_photo_grapher_app/models/loggable.model.dart';
import 'package:punch_clock_photo_grapher_app/models/state.model.dart';
import 'package:redux/redux.dart';

class ListModel implements LoggableModel {
  final String data;

  ListModel({
    required this.data,
  });

  ListModel.empty() : data = "";

  @override
  int get hashCode => data.hashCode;

  @override
  bool operator ==(
    Object other,
  ) {
    if (other is! ListModel) {
      return false;
    }
    return data.compareTo(
          other.data,
        ) ==
        0;
  }

  @override
  Map<String, dynamic> asLog() => <String, dynamic>{
        "data": data,
      };

  static ListModel? select(
    Store<StateModel> store,
  ) =>
      store.state.list;
}
