import 'package:ajanchat/models/RelationPreferences.dart';
import 'package:ajanchat/models/place_model.dart';

class AjanModel {
  String? phoneNumber;
  DateTime? createdAt;
  String? displayName;
  late DateTime birthDate;
  late List<String> preferences;
  RelationPreferences? relationPreferences;
  late List<String> images;
  PlaceModel? location;
  bool isActive;

  AjanModel({
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
}