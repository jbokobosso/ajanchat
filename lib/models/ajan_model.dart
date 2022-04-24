import 'package:ajanchat/models/RelationPreferences.dart';
import 'package:ajanchat/models/place_model.dart';
import 'package:ajanchat/utils/utils.dart';

class AjanModel {
  String id;
  String? phoneNumber;
  DateTime? createdAt;
  String? displayName;
  late DateTime birthDate;
  late List<dynamic> preferences;
  RelationPreferences? relationPreferences;
  late List<dynamic> images;
  PlaceModel? location;
  bool isActive;
  List<dynamic> likedAjanList;
  List<dynamic> dislikedAjanList;

  AjanModel({
    this.id = "",
    this.phoneNumber,
    this.createdAt,
    this.displayName,
    required this.birthDate,
    required this.preferences,
    this.relationPreferences,
    required this.images,
    this.location,
    this.isActive = true,
    required this.likedAjanList,
    required this.dislikedAjanList,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "phoneNumber": phoneNumber,
      "createdAt": createdAt,
      "displayName": displayName,
      "birthDate": birthDate,
      "preferences": preferences,
      "relationPreferences": relationPreferences!.toMap(),
      "images": images,
      "location": location!.toMap(),
      "isActive": isActive,
      "likedAjanList": likedAjanList,
      "dislikedAjanList": dislikedAjanList
    };
  }

  static AjanModel fromMap(Map<String, dynamic> firebaseData, String firebaseId) {
    return AjanModel(
      id: firebaseId,
      phoneNumber: firebaseData['phoneNumber'],
      createdAt: Utils.timestampToDateTime(firebaseData['createdAt']),
      displayName: firebaseData['displayName'],
      birthDate: Utils.timestampToDateTime(firebaseData['birthDate']),
      preferences: firebaseData['preferences'],
      relationPreferences: RelationPreferences.fromMap(firebaseData['relationPreferences']),
      images: firebaseData['images'],
      location: PlaceModel.fromMap(firebaseData['location']),
      isActive: firebaseData['isActive'],
      likedAjanList: firebaseData['likedAjanList'],
      dislikedAjanList: firebaseData['dislikedAjanList']
    );
  }
}