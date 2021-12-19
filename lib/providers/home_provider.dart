import 'package:ajanchat/constants/file_assets.dart';
import 'package:ajanchat/models/ERelationType.dart';
import 'package:ajanchat/models/RelationPreferences.dart';
import 'package:ajanchat/models/ajan_model.dart';
import 'package:flutter/foundation.dart';

class HomeProvider extends ChangeNotifier {
  List<AjanModel> ajanList = [
    AjanModel(displayName: "Josué BOKOBOSSO", birthDate: DateTime.parse("1997-03-25 20:15:04Z"), preferences: ["Moto, Cinéma, Cuisine, Voyages, Bouffe"], relationPreferences: RelationPreferences(iam: Gender.male, iWannaMeet: Gender.female, relationType: ERelationType.serious), images: [FileAssets.ajan4, FileAssets.ajan2]),
    AjanModel(displayName: "Aristide KARBOU", birthDate: DateTime.parse("2000-03-25 20:15:04Z"), preferences: ["Tiktok, Social, Motos"], relationPreferences: RelationPreferences(iam: Gender.male, iWannaMeet: Gender.female, relationType: ERelationType.serious), images: [FileAssets.ajan5, FileAssets.ajan2]),
    AjanModel(displayName: "Gloria BAGED", birthDate: DateTime.parse("2002-03-25 20:15:04Z"), preferences: ["Fiesta, Cuisine, Bouffe"], relationPreferences: RelationPreferences(iam: Gender.male, iWannaMeet: Gender.female, relationType: ERelationType.serious), images: [FileAssets.ajan2, FileAssets.ajan3]),
    AjanModel(displayName: "Hervé KAO", birthDate: DateTime.parse("1999-03-25 20:15:04Z"), preferences: ["Kabyè, Badass, Lecture"], relationPreferences: RelationPreferences(iam: Gender.male, iWannaMeet: Gender.female, relationType: ERelationType.serious), images: [FileAssets.ajan3, FileAssets.ajan2]),
    AjanModel(displayName: "Constantine SIOU", birthDate: DateTime.parse("1998-03-25 20:15:04Z"), preferences: ["Comptable, Rigueur, Love Story"], relationPreferences: RelationPreferences(iam: Gender.male, iWannaMeet: Gender.female, relationType: ERelationType.serious), images: [FileAssets.ajan1, FileAssets.ajan2]),
  ];
  
  
}