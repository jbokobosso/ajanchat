import 'dart:io';

import 'package:ajanchat/constants/ajan_preferences.dart';
import 'package:ajanchat/models/ERelationType.dart';
import 'package:ajanchat/models/PreferenceModel.dart';
import 'package:ajanchat/models/RelationPreferences.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class AuthProvider extends ChangeNotifier {

  RelationPreferences genderPreference = RelationPreferences(iam: Gender.spartan, iWannaMeet: Gender.spartan, relationType: ERelationType.spartan);
  List<PreferenceModel> preferences = availablePreferences;
  late File image = File("");
  List<File> images = [];
  final picker = ImagePicker();
  var currentTabIndex = 0;

  void selectGender(Gender gender) {
    switch(gender) {
      case Gender.female:
        genderPreference.iam = gender;
        break;
      case Gender.male:
        genderPreference.iam = gender;
        break;
    }
    notifyListeners();
  }

  void selectPartnerGender(Gender gender) {
    switch(gender) {
      case Gender.female:
        genderPreference.iWannaMeet = gender;
        break;
      case Gender.male:
        genderPreference.iWannaMeet = gender;
        break;
    }
    notifyListeners();
  }

  void selectRelationType(ERelationType relationType) {
    switch(relationType) {
      case ERelationType.friend:
        genderPreference.relationType = relationType;
        break;
      case ERelationType.serious:
        genderPreference.relationType = relationType;
        break;
      case ERelationType.flirt:
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