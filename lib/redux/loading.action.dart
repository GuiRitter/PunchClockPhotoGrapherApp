import 'package:dio/dio.dart';
import 'package:punch_clock_photo_grapher_app/models/loading_tag.model.dart';
import 'package:punch_clock_photo_grapher_app/models/state.model.dart';
import 'package:punch_clock_photo_grapher_app/utils/date_time.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<StateModel> addLoading({
  required List<LoadingTagModel> list,
}) =>
    (
      Store<StateModel> store,
    ) async =>
        store.dispatch(
          AddLoadingAction(
            list: list,
          ),
        );

LoadingTagModel buildLoadingTag({
  required String userFriendlyName,
  required CancelToken cancelToken,
}) =>
    LoadingTagModel(
      id: getISO8601(
        dateTime: DateTime.now(),
      )!,
      userFriendlyName: userFriendlyName,
      cancelToken: cancelToken,
    );

ThunkAction<StateModel> cancelLoading({
  required String id,
}) =>
    (
      Store<StateModel> store,
    ) async {
      final loadingTag = store.state.loadingTagList.firstWhere(
        LoadingTagModel.idEquals(
          id,
        ),
      );

      loadingTag.cancelToken.cancel();
    };

ThunkAction<StateModel> removeLoading({
  required List<String> idList,
}) =>
    (
      Store<StateModel> store,
    ) async =>
        store.dispatch(
          RemoveLoadingAction(
            idList: idList,
          ),
        );

class AddLoadingAction {
  final List<LoadingTagModel> list;

  const AddLoadingAction({
    required this.list,
  });
}

class CancelLoadingAction {
  final String id;

  const CancelLoadingAction({
    required this.id,
  });
}

class RemoveLoadingAction {
  final List<String> idList;

  const RemoveLoadingAction({
    required this.idList,
  });
}
