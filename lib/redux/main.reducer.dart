import 'package:flutter_guiritter/util/util.import.dart' show logger;
import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show StateModel;
import 'package:punch_clock_photo_grapher_app/redux/data/reducer.dart'
    show dataCombinedReducer;
import 'package:punch_clock_photo_grapher_app/redux/l10n/reducer.dart'
    show l10nCombinedReducer;
import 'package:punch_clock_photo_grapher_app/redux/loading/reducer.dart'
    show loadingCombinedReducer;
import 'package:punch_clock_photo_grapher_app/redux/navigation/reducer.dart'
    show navigationCombinedReducer;
import 'package:punch_clock_photo_grapher_app/redux/theme/reducer.dart'
    show themeCombinedReducer;
import 'package:punch_clock_photo_grapher_app/redux/user/reducer.dart'
    show userCombinedReducer;
import 'package:redux/redux.dart' show TypedReducer, combineReducers;

late dynamic Function(
  dynamic,
) dispatch;

final noActionTypedReducer = TypedReducer<StateModel, NoAction>(
  noActionReducer,
).call;

final _log = logger('main.reducer');

StateModel noActionReducer(
  StateModel stateModel,
  NoAction action,
) =>
    stateModel;

StateModel reducer(
  StateModel stateModel,
  dynamic action,
) {
  _log('reducer').asString('action', action.runtimeType).print();

  final reducerCombined = combineReducers<StateModel>(
    [
      dataCombinedReducer,
      l10nCombinedReducer,
      loadingCombinedReducer,
      navigationCombinedReducer,
      noActionTypedReducer,
      themeCombinedReducer,
      userCombinedReducer,
    ],
  );

  return reducerCombined(
    stateModel,
    action,
  );
}

class NoAction {}
