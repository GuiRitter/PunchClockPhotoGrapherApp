import 'package:punch_clock_photo_grapher_app/common/api_url.enum.dart';
import 'package:punch_clock_photo_grapher_app/common/settings.dart' show l10n;
import 'package:punch_clock_photo_grapher_app/models/list.model.dart';
import 'package:punch_clock_photo_grapher_app/models/result.dart';
import 'package:punch_clock_photo_grapher_app/models/state.model.dart';
import 'package:punch_clock_photo_grapher_app/redux/dio.action.dart'
    as dio_action;
import 'package:punch_clock_photo_grapher_app/utils/logger.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

final _log = logger("data.action");

ThunkAction<StateModel> getList() => (
      Store<StateModel> store,
    ) async {
      _log("getList").print();

      Future<void> getListSuccess({
        required Result result,
      }) async {
        _log("getList").map("result", result).print();

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

class DataAction {
  final ListModel? list;

  const DataAction({
    required this.list,
  });
}
