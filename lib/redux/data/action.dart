import 'dart:convert' show base64Encode;
import 'dart:math' show min;
import 'dart:typed_data' show Uint8List;

import 'package:flutter/material.dart' show TimeOfDay;
import 'package:flutter_guiritter/common/common.import.dart' show base64Prefix;
import 'package:flutter_guiritter/model/model.import.dart' show Result;
import 'package:flutter_guiritter/redux/api/action.dart' as api_action;
import 'package:flutter_guiritter/util/util.import.dart'
    show DateTimeNullableExtension, logger;
import 'package:image/image.dart'
    show copyCrop, copyResize, decodeJpg, encodePng;
import 'package:image_picker/image_picker.dart'
    show ImagePicker, ImageSource, XFile;
import 'package:punch_clock_photo_grapher_app/common/common.import.dart'
    show ApiUrl, StateEnum;
import 'package:punch_clock_photo_grapher_app/model/model.import.dart'
    show ListModel, SavePhotoRequestModel, StateModel;
import 'package:punch_clock_photo_grapher_app/redux/navigation/action.dart'
    as navigation_action;
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
        api_action.get(
          url: ApiUrl.photo.path,
          userFriendlyName: store.state.l10n!.loadingTag_getList,
          thenFunction: getListSuccess,
        ),
      );
    };

ThunkAction<StateModel> savePhoto() => (
      Store<StateModel> store,
    ) async {
      _log('savePhoto').print();

      if (store.state.photoBytes == null) return;

      final photoBase64 = base64Encode(
        store.state.photoBytes!,
      );

      final photoURI = '$base64Prefix$photoBase64';

      Future<void> savePhotoSuccess({
        required Result result,
      }) async {
        _log('savePhoto').map('result', result).print();

        store.dispatch(
          getList(),
        );

        store.dispatch(
          navigation_action.go(
            state: StateEnum.list,
          ),
        );
      }

      final requestData = SavePhotoRequestModel(
        dateTime: store.state.dateTime.getISO8601()!,
        imageURI: photoURI,
      );

      store.dispatch(
        api_action.post(
          url: ApiUrl.photo.path,
          data: requestData,
          userFriendlyName: store.state.l10n!.loadingTag_savePhoto,
          thenFunction: savePhotoSuccess,
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

ThunkAction<StateModel> setPhotoImage() => (
      Store<StateModel> store,
    ) async {
      _log('setPhotoImage').print();

      final ImagePicker picker = ImagePicker();

      final XFile? photoFile = await picker.pickImage(
        source: ImageSource.camera,
      );

      if (photoFile == null) return;

      var photoImage = decodeJpg(
        await photoFile.readAsBytes(),
      )!;

      final x = (photoImage.width > photoImage.height)
          ? ((photoImage.width - photoImage.height) ~/ 2)
          : 0;

      final y = (photoImage.height > photoImage.width)
          ? ((photoImage.height - photoImage.width) ~/ 2)
          : 0;

      var dimension = min(
        photoImage.width,
        photoImage.height,
      );

      photoImage = copyCrop(
        photoImage,
        x: x,
        y: y,
        width: dimension,
        height: dimension,
      );

      dimension = min(
        dimension,
        // TODO make an option
        480,
      );

      photoImage = copyResize(
        photoImage,
        width: dimension,
        height: dimension,
      );

      final photoBytes = encodePng(
        photoImage,
      );

      store.dispatch(
        SetPhotoAction(
          photoBytes: photoBytes,
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

class SetPhotoAction {
  final Uint8List photoBytes;

  const SetPhotoAction({
    required this.photoBytes,
  });
}

class SetTimeAction {
  final TimeOfDay time;

  const SetTimeAction({
    required this.time,
  });
}
