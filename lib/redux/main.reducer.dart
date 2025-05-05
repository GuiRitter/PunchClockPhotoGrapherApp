import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show StateModel;
import 'package:punch_clock_photo_grapher_app/redux/data.action.dart'
    show
        dataTypedReducer,
        setDateTypedReducer,
        setPhotoTypedReducer,
        setTimeTypedReducer;
import 'package:punch_clock_photo_grapher_app/redux/l10n.action.dart'
    show setL10nTypedReducer;
import 'package:punch_clock_photo_grapher_app/redux/loading.action.dart'
    show
        addLoadingTypedReducer,
        cancelLoadingTypedReducer,
        removeLoadingTypedReducer;
import 'package:punch_clock_photo_grapher_app/redux/navigation.action.dart'
    show goTypedReducer;
import 'package:punch_clock_photo_grapher_app/redux/theme.action.dart';
import 'package:punch_clock_photo_grapher_app/redux/user.action.dart'
    show setTokenTypedReducer;
import 'package:punch_clock_photo_grapher_app/utils/utils.import.dart'
    show logger;
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
      setL10nTypedReducer,
      setTokenTypedReducer,
      addLoadingTypedReducer,
      cancelLoadingTypedReducer,
      dataTypedReducer,
      goTypedReducer,
      removeLoadingTypedReducer,
      setDateTypedReducer,
      setPhotoTypedReducer,
      setTimeTypedReducer,
      setThemeTypedReducer,
      noActionTypedReducer,
    ],
  );

  return reducerCombined(
    stateModel,
    action,
  );
}

class NoAction {}
