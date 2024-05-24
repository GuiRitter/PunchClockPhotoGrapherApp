import 'package:punch_clock_photo_grapher_app/models/models.import.dart'
    show BaseRequestModel;
import 'package:punch_clock_photo_grapher_app/utils/utils.import.dart'
    show hideSecret;

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
