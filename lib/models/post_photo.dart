class PostPhoto {
  late String dateTime;
  late String dataURI;

  PostPhoto({required this.dateTime, required this.dataURI});

  PostPhoto.fromJson(Map<String, dynamic> json) {
    dateTime = json['dateTime'];
    dataURI = json['dataURI'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dateTime'] = dateTime;
    data['dataURI'] = dataURI;
    return data;
  }
}
