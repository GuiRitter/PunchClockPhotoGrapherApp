import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show StateModel;
import 'package:punch_clock_photo_grapher_app/redux/data/action.dart'
    show DataAction, SetDateAction, SetPhotoAction, SetTimeAction;
import 'package:redux/redux.dart' show TypedReducer, combineReducers;

final dataCombinedReducer = combineReducers<StateModel>(
  [
    dataTypedReducer,
    setDateTypedReducer,
    setPhotoTypedReducer,
    setTimeTypedReducer,
  ],
);

final dataTypedReducer = TypedReducer<StateModel, DataAction>(
  dataReducer,
).call;

final setDateTypedReducer = TypedReducer<StateModel, SetDateAction>(
  setDateReducer,
).call;

final setPhotoTypedReducer = TypedReducer<StateModel, SetPhotoAction>(
  setPhotoReducer,
).call;

final setTimeTypedReducer = TypedReducer<StateModel, SetTimeAction>(
  setTimeReducer,
).call;

StateModel dataReducer(
  StateModel stateModel,
  DataAction action,
) =>
    stateModel.copyWith(
      list: () => action.list,
    );

StateModel setDateReducer(
  StateModel stateModel,
  SetDateAction action,
) =>
    stateModel.withDate(
      date: action.date,
    );

StateModel setPhotoReducer(
  StateModel stateModel,
  SetPhotoAction action,
) =>
    stateModel.copyWith(
      photoBytes: () => action.photoBytes,
    );

StateModel setTimeReducer(
  StateModel stateModel,
  SetTimeAction action,
) =>
    stateModel.withTime(
      time: action.time,
    );
