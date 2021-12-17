import 'package:ajanchat/models/RelationPreferences.dart';
import 'package:flutter/foundation.dart';
import 'package:rive/rive.dart';

class AuthProvider extends ChangeNotifier {
  late Artboard riveArtboard;
  RiveAnimationController controller = SimpleAnimation('discover');

  late RelationPreferences genderPreference = RelationPreferences(iam: Gender.Homme, iWannaMeet: Gender.Femme, relationType: RelationType.Flirt);

  selectGender(Gender gender) {
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

  selectPartnerGender(Gender gender) {
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

  selectRelationType(RelationType relationType) {
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
}