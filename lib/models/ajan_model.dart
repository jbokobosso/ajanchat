import 'package:ajanchat/models/RelationPreferences.dart';

class AjanModel {
  String displayName;
  DateTime birthDate;
  List<String> preferences;
  RelationPreferences relationPreferences;
  List<String> images;

  AjanModel({
    required this.displayName,
    required this.birthDate,
    required this.preferences,
    required this.relationPreferences,
    required this.images
  });
}