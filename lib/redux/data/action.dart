import 'dart:convert' show base64Encode;
import 'dart:math' show min;
import 'dart:typed_data' show Uint8List;

import 'package:flutter/material.dart' show TimeOfDay;
import 'package:flutter_guiritter/common/_import.dart' show base64Prefix;
import 'package:flutter_guiritter/extension/_import.dart'
    show DateTimeNullableExtension;
import 'package:flutter_guiritter/model/_import.dart' show Result;
import 'package:flutter_guiritter/redux/api/action.dart' as api_action;
import 'package:flutter_guiritter/util/_import.dart' show logger;
import 'package:image/image.dart'
    show copyCrop, copyResize, decodeJpg, encodePng;
import 'package:image_picker/image_picker.dart'
    show ImagePicker, ImageSource, XFile;
import 'package:punch_clock_photo_grapher_app/common/_import.dart'
    show ApiUrl, StateEnum;
import 'package:punch_clock_photo_grapher_app/model/_import.dart'
    show ListModel, SavePhotoRequestModel, StateModelWrapper;
import 'package:punch_clock_photo_grapher_app/redux/navigation/action.dart'
    as navigation_action;
import 'package:redux/redux.dart' show Store;
import 'package:redux_thunk/redux_thunk.dart' show ThunkAction;

final _log = logger('data.action');

ThunkAction<Map<String, dynamic>> getList() => (
      Store<Map<String, dynamic>> store,
    ) async {
      _log('getList').print();

      final state = StateModelWrapper(
        storeStateMap: store.state,
      );

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
          userFriendlyName: state.l10n!.loadingTag_getList,
          thenFunction: getListSuccess,
        ),
      );
    };

ThunkAction<Map<String, dynamic>> savePhoto() => (
      Store<Map<String, dynamic>> store,
    ) async {
      _log('savePhoto').print();

      final state = StateModelWrapper(
        storeStateMap: store.state,
      );

      if (state.photoByteList == null) return;

      final photoBase64 = base64Encode(
        state.photoByteList!,
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
        dateTime: state.dateTime.getISO8601()!,
        imageURI: photoURI,
      );

      store.dispatch(
        api_action.post(
          url: ApiUrl.photo.path,
          data: requestData,
          userFriendlyName: state.l10n!.loadingTag_savePhoto,
          thenFunction: savePhotoSuccess,
        ),
      );
    };

ThunkAction<Map<String, dynamic>> setDate({
  required DateTime? date,
}) =>
    (
      Store<Map<String, dynamic>> store,
    ) async {
      _log('setDate').asString('date', date).print();

      if (date == null) return;

      store.dispatch(
        SetDateAction(
          date: date,
        ),
      );
    };

ThunkAction<Map<String, dynamic>> setPhotoImage() => (
      Store<Map<String, dynamic>> store,
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
          photoByteList: photoBytes,
        ),
      );
    };

ThunkAction<Map<String, dynamic>> setTime({
  required TimeOfDay? time,
}) =>
    (
      Store<Map<String, dynamic>> store,
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
  final Uint8List photoByteList;

  const SetPhotoAction({
    required this.photoByteList,
  });
}

class SetTimeAction {
  final TimeOfDay time;

  const SetTimeAction({
    required this.time,
  });
}
