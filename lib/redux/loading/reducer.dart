import 'package:flutter_guiritter/model/model.import.dart' show LoadingTagModel;
import 'package:flutter_guiritter/redux/loading/action.dart'
    show AddLoadingAction, CancelLoadingAction, RemoveLoadingAction;
import 'package:punch_clock_photo_grapher_app/model/model.import.dart'
    show StateModel;
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

StateModel cancelLoadingReducer(
  StateModel stateModel,
  CancelLoadingAction action,
) =>
    stateModel.withoutLoadingTagList(
      idList: [
        action.id,
      ],
    );

StateModel removeLoadingReducer(
  StateModel stateModel,
  RemoveLoadingAction action,
) =>
    stateModel.withoutLoadingTagList(
      idList: action.idList,
    );
