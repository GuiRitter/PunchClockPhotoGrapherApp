import 'package:flutter_guiritter/model/_import.dart' show BaseRequestModel;
import 'package:flutter_guiritter/util/_import.dart' show hideSecret;

class SavePhotoRequestModel implements BaseRequestModel {
  final String dateTime;
  final String imageURI;

  SavePhotoRequestModel({
    required this.dateTime,
    required this.imageURI,
  });

  @override
  Map<String, dynamic> asLog() => <String, dynamic>{
        'dateTime': dateTime,
        'imageURI': hideSecret(
          imageURI,
        ),
      };

  @override
  Map<String, dynamic> toJson() => {
        'dateTime': dateTime,
        'dataURI': imageURI,
      };
}
