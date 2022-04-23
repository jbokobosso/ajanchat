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

  static PlaceModel fromMap(Map<String, dynamic> firebaseData) {
    return PlaceModel(
      firebaseData['latitude'],
      firebaseData['longitude'],
      placeId: firebaseData['placeId'] ?? ""
    );
  }
}