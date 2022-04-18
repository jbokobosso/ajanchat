class PlaceModel {
  double latitude;
  double longitude;
  String placeId;

  PlaceModel(this.latitude, this.longitude, {this.placeId = ""});

  Map<String, dynamic> toMap() {
    return {
      "latitude": latitude,
      "longitude": longitude,
      "placeId": placeId
    };
  }
}