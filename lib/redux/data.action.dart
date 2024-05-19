import 'package:flutter/material.dart' show TimeOfDay;
import 'package:punch_clock_photo_grapher_app/common/common.import.dart'
    show ApiUrl, l10n;
import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show ListModel, Result, StateModel;
import 'package:punch_clock_photo_grapher_app/redux/dio.action.dart'
    as dio_action;
import 'package:punch_clock_photo_grapher_app/utils/utils.import.dart'
    show logger;
import 'package:redux/redux.dart' show Store;
import 'package:redux_thunk/redux_thunk.dart' show ThunkAction;

final _log = logger('data.action');

ThunkAction<StateModel> getList() => (
      Store<StateModel> store,
    ) async {
      _log('getList').print();

      Future<void> getListSuccess({
        required Result result,
      }) async {
        _log('getList').map('result', result).print();

        store.dispatch(
          DataAction(
            list: ListModel(
              data: result.data,
            ),
          ),
        );
      }

      store.dispatch(
        dio_action.get(
          url: ApiUrl.getList.path,
          userFriendlyName: l10n.loadingTag_getList,
          thenFunction: getListSuccess,
        ),
      );
    };

ThunkAction<StateModel> setDate({
  required DateTime? date,
}) =>
    (
      Store<StateModel> store,
    ) async {
      _log('setDate').asString('date', date).print();

      if (date == null) return;

      store.dispatch(
        SetDateAction(
          date: date,
        ),
      );
    };

ThunkAction<StateModel> setTime({
  required TimeOfDay? time,
}) =>
    (
      Store<StateModel> store,
    ) async {
      _log('setDate').asString('time', time).print();

      if (time == null) return;

      store.dispatch(
        SetTimeAction(
          time: time,
        ),
      );
    };

class DataAction {
  final ListModel? list;

  const DataAction({
    required this.list,
  });
}

class SetDateAction {
  final DateTime date;

  const SetDateAction({
    required this.date,
  });
}

class SetTimeAction {
  final TimeOfDay time;

  const SetTimeAction({
    required this.time,
  });
}
