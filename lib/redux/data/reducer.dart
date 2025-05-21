import 'package:punch_clock_photo_grapher_app/model/model.import.dart'
    show StateModelWrapper;
import 'package:punch_clock_photo_grapher_app/redux/data/action.dart'
    show DataAction, SetDateAction, SetPhotoAction, SetTimeAction;
import 'package:redux/redux.dart' show TypedReducer, combineReducers;

final dataCombinedReducer = combineReducers<Map<String, dynamic>>(
  [
    dataTypedReducer,
    setDateTypedReducer,
    setPhotoTypedReducer,
    setTimeTypedReducer,
  ],
);

final dataTypedReducer = TypedReducer<Map<String, dynamic>, DataAction>(
  dataReducer,
).call;

final setDateTypedReducer = TypedReducer<Map<String, dynamic>, SetDateAction>(
  setDateReducer,
).call;

final setPhotoTypedReducer = TypedReducer<Map<String, dynamic>, SetPhotoAction>(
  setPhotoReducer,
).call;

final setTimeTypedReducer = TypedReducer<Map<String, dynamic>, SetTimeAction>(
  setTimeReducer,
).call;

Map<String, dynamic> dataReducer(
  Map<String, dynamic> stateModelMap,
  DataAction action,
) =>
    StateModelWrapper(
      storeStateMap: stateModelMap,
    ).copyWith(
      list: () => action.list,
    );

Map<String, dynamic> setDateReducer(
  Map<String, dynamic> stateModelMap,
  SetDateAction action,
) =>
    StateModelWrapper(
      storeStateMap: stateModelMap,
    ).withDate(
      date: action.date,
    );

Map<String, dynamic> setPhotoReducer(
  Map<String, dynamic> stateModelMap,
  SetPhotoAction action,
) =>
    StateModelWrapper(
      storeStateMap: stateModelMap,
    ).copyWith(
      photoByteList: () => action.photoByteList,
    );

Map<String, dynamic> setTimeReducer(
  Map<String, dynamic> stateModelMap,
  SetTimeAction action,
) =>
    StateModelWrapper(
      storeStateMap: stateModelMap,
    ).withTime(
      time: action.time,
    );
