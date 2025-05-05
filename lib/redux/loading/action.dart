import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show LoadingTagModel, StateModel;
import 'package:redux/redux.dart' show Store;
import 'package:redux_thunk/redux_thunk.dart' show ThunkAction;

ThunkAction<StateModel> add({
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

ThunkAction<StateModel> cancel({
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

ThunkAction<StateModel> remove({
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
