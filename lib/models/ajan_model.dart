import 'package:ajanchat/models/RelationPreferences.dart';
import 'package:ajanchat/models/place_model.dart';
import 'package:ajanchat/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  List<String> likingsAjans = [];

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
    this.isActive = true
  });

  Map<String, dynamic> toMap() {
    return {
      "phoneNumber": phoneNumber,
      "createdAt": createdAt,
      "displayName": displayName,
      "birthDate": birthDate,
      "preferences": preferences,
      "relationPreferences": relationPreferences!.toMap(),
      "images": images,
      "location": location!.toMap(),
    };
  }

  static AjanModel fromMap(Map<String, dynamic> jsonData, String firebaseId) {
    return AjanModel(
      id: firebaseId,
      phoneNumber: jsonData['phoneNumber'],
      createdAt: Utils.timestampToDateTime(jsonData['createdAt']),
      displayName: jsonData['displayName'],
      birthDate: Utils.timestampToDateTime(jsonData['birthDate']),
      preferences: jsonData['preferences'],
      relationPreferences: RelationPreferences.fromMap(jsonData['relationPreferences']),
      images: jsonData['images'],
      location: PlaceModel.fromMap(jsonData['location'])
    );
  }
}