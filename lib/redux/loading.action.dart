import 'package:punch_clock_photo_grapher_app/common/operation.enum.dart';
import 'package:punch_clock_photo_grapher_app/models/state.model.dart';
import 'package:punch_clock_photo_grapher_app/utils/date_time.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<StateModel> addLoading({
  required List<String> tagList,
}) =>
    (
      Store<StateModel> store,
    ) async =>
        store.dispatch(
          LoadingAction(
            operation: OperationEnum.add,
            tagList: tagList,
          ),
        );

String buildLoadingTag({
  required String suffix,
}) =>
    "${getISO8601(
      dateTime: DateTime.now(),
    )} $suffix";

ThunkAction<StateModel> removeLoading({
  required List<String> tagList,
}) =>
    (
      Store<StateModel> store,
    ) async =>
        store.dispatch(
          LoadingAction(
            operation: OperationEnum.remove,
            tagList: tagList,
          ),
        );

class LoadingAction {
  final OperationEnum operation;
  final List<String> tagList;

  const LoadingAction({
    required this.operation,
    required this.tagList,
  });
}
