import 'dart:io';

import 'package:ajanchat/constants/ajan_preferences.dart';
import 'package:ajanchat/models/PreferenceModel.dart';
import 'package:ajanchat/models/RelationPreferences.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class AuthProvider extends ChangeNotifier {

  RelationPreferences genderPreference = RelationPreferences(iam: Gender.Homme, iWannaMeet: Gender.Femme, relationType: RelationType.Flirt);
  List<PreferenceModel> preferences = availablePreferences;
  late File image = File("");
  List<File> images = [];
  final picker = ImagePicker();
  var currentTabIndex = 0;

  void selectGender(Gender gender) {
    switch(gender) {
      case Gender.Femme:
        genderPreference.iam = gender;
        break;
      case Gender.Homme:
        genderPreference.iam = gender;
        break;
    }
    notifyListeners();
  }

  void selectPartnerGender(Gender gender) {
    switch(gender) {
      case Gender.Femme:
        genderPreference.iWannaMeet = gender;
        break;
      case Gender.Homme:
        genderPreference.iWannaMeet = gender;
        break;
    }
    notifyListeners();
  }

  void selectRelationType(RelationType relationType) {
    switch(relationType) {
      case RelationType.Amicale:
        genderPreference.relationType = relationType;
        break;
      case RelationType.Serieuse:
        genderPreference.relationType = relationType;
        break;
      case RelationType.Flirt:
        genderPreference.relationType = relationType;
        break;
    }
    notifyListeners();
  }

  void selectOrUnselectPreference(int index) {
    preferences[index].isChosen = !preferences[index].isChosen;
    notifyListeners();
  }

  Future<void> pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
    } else {
      // this.coreService.showToast("Pas d'image sélectionnée");
    }
    notifyListeners();
  }

  void clearPictures() {
    image = File("");
    notifyListeners();
  }

  void changeTabIndex(int newIndex) {
    currentTabIndex = newIndex;
    notifyListeners();
  }
}