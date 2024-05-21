import 'dart:math' show min;

import 'package:flutter/material.dart' show Image;
import 'package:image_picker/image_picker.dart' show XFile;
import 'package:image/image.dart' show copyCrop, decodeJpg, encodePng;

extension ImageExtension on XFile? {
  Future<Image?> toImageCroppedToSquare() async {
    if (this == null) return null;

    var photoImage = decodeJpg(
      await this!.readAsBytes(),
    )!;

    final x = (photoImage.width > photoImage.height)
        ? ((photoImage.width - photoImage.height) ~/ 2)
        : 0;

    final y = (photoImage.height > photoImage.width)
        ? ((photoImage.height - photoImage.width) ~/ 2)
        : 0;

    final dimension = min(
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

    final photoImageBytes = encodePng(
      photoImage,
    );

    return Image.memory(
      photoImageBytes,
    );
  }
}
