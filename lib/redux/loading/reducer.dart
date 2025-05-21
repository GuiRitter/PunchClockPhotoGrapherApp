import 'package:flutter_guiritter/redux/loading/action.dart'
    show AddLoadingAction, CancelLoadingAction, RemoveLoadingAction;
import 'package:punch_clock_photo_grapher_app/model/model.import.dart'
    show StateModelWrapper;
import 'package:redux/redux.dart' show TypedReducer, combineReducers;

final addLoadingTypedReducer =
    TypedReducer<Map<String, dynamic>, AddLoadingAction>(
  addLoadingReducer,
).call;

final cancelLoadingTypedReducer =
    TypedReducer<Map<String, dynamic>, CancelLoadingAction>(
  cancelLoadingReducer,
).call;

final loadingCombinedReducer = combineReducers<Map<String, dynamic>>(
  [
    addLoadingTypedReducer,
    cancelLoadingTypedReducer,
    removeLoadingTypedReducer,
  ],
);

final removeLoadingTypedReducer =
    TypedReducer<Map<String, dynamic>, RemoveLoadingAction>(
  removeLoadingReducer,
).call;

Map<String, dynamic> addLoadingReducer(
  Map<String, dynamic> stateModelMap,
  AddLoadingAction action,
) =>
    StateModelWrapper(
      storeStateMap: stateModelMap,
    ).withLoadingTagList(
      newLoadingTagList: action.list,
    );

Map<String, dynamic> cancelLoadingReducer(
  Map<String, dynamic> stateModelMap,
  CancelLoadingAction action,
) =>
    StateModelWrapper(
      storeStateMap: stateModelMap,
    ).withoutLoadingTagList(
      idList: [
        action.id,
      ],
    );

Map<String, dynamic> removeLoadingReducer(
  Map<String, dynamic> stateModelMap,
  RemoveLoadingAction action,
) =>
    StateModelWrapper(
      storeStateMap: stateModelMap,
    ).withoutLoadingTagList(
      idList: action.idList,
    );
