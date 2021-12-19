
import 'package:ajanchat/models/ERelationType.dart';

class RelationPreferences {
  Gender iam;
  Gender iWannaMeet;
  ERelationType relationType;

  RelationPreferences({
    required this.iam,
    required this.iWannaMeet,
    required this.relationType
  });
}

enum Gender {
  male,
  female,
  spartan
}
