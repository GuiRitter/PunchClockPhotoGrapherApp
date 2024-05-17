import 'package:flutter/material.dart' show BuildContext, Navigator;
import 'package:punch_clock_photo_grapher_app/utils/utils.import.dart'
    show logger;

final _log = logger('utils/dialogs');

onDialogCancelPressed({
  required BuildContext context,
}) {
  _log('onDialogCancelPressed').print();

  Navigator.pop(
    context,
  );
}
