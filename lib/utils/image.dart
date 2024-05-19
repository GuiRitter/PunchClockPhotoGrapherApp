import 'package:flutter/material.dart' show Image;
import 'package:image_picker/image_picker.dart' show XFile;

extension ImageExtension on XFile? {
  Future<Image?> toImage() async {
    return (this != null)
        ? Image.memory(
            await this!.readAsBytes(),
          )
        : null;
  }
}
