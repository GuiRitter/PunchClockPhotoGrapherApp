import 'package:dio/dio.dart' show CancelToken;
import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show LoadingTagModel, StateModel;
import 'package:punch_clock_photo_grapher_app/utils/utils.import.dart'
    show DateTimeNullableExtension;
import 'package:redux/redux.dart' show Store, TypedReducer, combineReducers;
import 'package:redux_thunk/redux_thunk.dart' show ThunkAction;

final addLoadingTypedReducer = TypedReducer<StateModel, AddLoadingAction>(
  addLoadingReducer,
).call;

final cancelLoadingTypedReducer = TypedReducer<StateModel, CancelLoadingAction>(
  cancelLoadingReducer,
).call;

final loadingCombinedReducer = combineReducers<StateModel>(
  [
    addLoadingTypedReducer,
    cancelLoadingTypedReducer,
    removeLoadingTypedReducer,
  ],
);

final removeLoadingTypedReducer = TypedReducer<StateModel, RemoveLoadingAction>(
  removeLoadingReducer,
).call;

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

StateModel addLoadingReducer(
  StateModel stateModel,
  AddLoadingAction action,
) =>
    stateModel.withLoadingTagList(
      newLoadingTagList: action.list,
    );

LoadingTagModel buildTag({
  required String userFriendlyName,
  required CancelToken cancelToken,
}) =>
    LoadingTagModel(
      id: DateTime.now().getISO8601()!,
      userFriendlyName: userFriendlyName,
      cancelToken: cancelToken,
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

StateModel cancelLoadingReducer(
  StateModel stateModel,
  CancelLoadingAction action,
) =>
    stateModel.withoutLoadingTagList(
      idList: [
        action.id,
      ],
    );

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

StateModel removeLoadingReducer(
  StateModel stateModel,
  RemoveLoadingAction action,
) =>
    stateModel.withoutLoadingTagList(
      idList: action.idList,
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
