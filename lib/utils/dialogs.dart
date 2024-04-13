import 'package:flutter/material.dart';
import 'package:punch_clock_photo_grapher_app/utils/logger.dart';

final _log = logger("utils/dialogs");

onDialogCancelPressed({
  required BuildContext context,
}) {
  _log("onDialogCancelPressed").print();

  Navigator.pop(
    context,
  );
}
