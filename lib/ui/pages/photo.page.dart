import 'dart:typed_data' show Uint8List;

import 'package:flutter/material.dart'
    show
        Alignment,
        AspectRatio,
        AsyncSnapshot,
        BackButton,
        BuildContext,
        Center,
        CircularProgressIndicator,
        Column,
        ConnectionState,
        Container,
        CrossAxisAlignment,
        EdgeInsets,
        ElevatedButton,
        Expanded,
        FutureBuilder,
        Icon,
        Icons,
        Image,
        MainAxisAlignment,
        Padding,
        Row,
        SizedBox,
        StatelessWidget,
        Text,
        Theme,
        TimeOfDay,
        Widget,
        showDatePicker,
        showTimePicker;
import 'package:flutter_redux/flutter_redux.dart' show StoreConnector;
import 'package:punch_clock_photo_grapher_app/common/common.import.dart'
    show StateEnum, l10n;
import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show PhotoModel, StateModel;
import 'package:punch_clock_photo_grapher_app/redux/data.action.dart'
    as data_action;
import 'package:punch_clock_photo_grapher_app/redux/main.reducer.dart'
    show getDispatch;
import 'package:punch_clock_photo_grapher_app/redux/navigation.action.dart'
    as navigation_action;
import 'package:punch_clock_photo_grapher_app/ui/widgets/widgets.import.dart'
    show AppBarSignedInWidget, BodyWidget, BottomAppBarWidget;

class PhotoPage extends StatelessWidget {
  const PhotoPage({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) =>
      StoreConnector<StateModel, PhotoModel>(
        distinct: true,
        converter: PhotoModel.select,
        builder: connectorBuilder,
      );

  Widget buildImage(
    context,
    AsyncSnapshot<Image?> snapshot,
  ) =>
      ((snapshot.connectionState == ConnectionState.done) &&
              (snapshot.data != null))
          ? snapshot.data!
          : const Center(
              child: CircularProgressIndicator(),
            );

  Widget connectorBuilder(
    BuildContext context,
    PhotoModel photoModel,
  ) {
    final dispatch = getDispatch(
      context: context,
    );

    final theme = Theme.of(
      context,
    );

    final fieldPadding = theme.textTheme.labelLarge?.fontSize ?? 0.0;

    onDatePressed() => pickDate(
          context: context,
          initialDate: photoModel.dateTime,
        );

    onTimePressed() => pickTime(
          context: context,
          initialDate: photoModel.dateTime,
        );

    onTakePhotoPressed() => takePhoto(
          context: context,
        );

    final takePhotoButton = ElevatedButton(
      onPressed: onTakePhotoPressed,
      child: const Icon(
        Icons.camera,
      ),
    );

    Future<Image?> buildImageFuture() async => loadImage(
          photoBytes: photoModel.photoBytes,
        );

    onSavePhotoPressed() {
      savePhoto(
        context: context,
      );
    }

    return BodyWidget(
      usePadding: false,
      appBar: AppBarSignedInWidget(
        appBarLeading: BackButton(
          onPressed: () => dispatch(
            navigation_action.go(
              state: StateEnum.list,
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: fieldPadding,
                right: fieldPadding,
                top: fieldPadding,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: (photoModel.photoBytes != null)
                        ? FutureBuilder<Image?>(
                            future: buildImageFuture(),
                            builder: buildImage,
                          )
                        : Container(
                            alignment: Alignment.center,
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: takePhotoButton,
                            ),
                          ),
                  ),
                  (photoModel.photoBytes != null)
                      ? takePhotoButton
                      : const SizedBox.shrink(),
                  SizedBox.square(
                    dimension: fieldPadding,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: onDatePressed,
                        child: Text(
                          photoModel.dateString,
                        ),
                      ),
                      SizedBox.square(
                        dimension: fieldPadding,
                      ),
                      ElevatedButton(
                        onPressed: onTimePressed,
                        child: Text(
                          photoModel.timeString,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          BottomAppBarWidget(
            onButtonPressed: onSavePhotoPressed,
            label: l10n.savePhoto,
          ),
        ],
      ),
    );
  }

  Future<Image?> loadImage({
    required Uint8List? photoBytes,
  }) async {
    if (photoBytes == null) return null;

    return Image.memory(
      photoBytes,
    );
  }

  pickDate({
    required BuildContext context,
    required DateTime initialDate,
  }) async {
    final dispatch = getDispatch(
      context: context,
    );

    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.fromMicrosecondsSinceEpoch(
        0,
      ),
      lastDate: DateTime.now(),
      initialDate: initialDate,
    );

    dispatch(
      data_action.setDate(
        date: date,
      ),
    );
  }

  pickTime({
    required BuildContext context,
    required DateTime initialDate,
  }) async {
    final dispatch = getDispatch(
      context: context,
    );

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
        initialDate,
      ),
    );

    dispatch(
      data_action.setTime(
        time: time,
      ),
    );
  }

  savePhoto({
    required BuildContext context,
  }) {
    final dispatch = getDispatch(
      context: context,
    );

    dispatch(
      data_action.savePhoto(),
    );
  }

  takePhoto({
    required BuildContext context,
  }) async {
    final dispatch = getDispatch(
      context: context,
    );

    dispatch(
      data_action.setPhotoImage(),
    );
  }
}
