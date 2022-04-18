
import 'package:ajanchat/models/ERelationType.dart';
import 'package:enum_to_string/enum_to_string.dart';

class RelationPreferences {
  Gender iam;
  Gender iWannaMeet;
  ERelationType relationType;

  RelationPreferences({
    required this.iam,
    required this.iWannaMeet,
    required this.relationType
  });

  Map<String, dynamic> toMap() {
    return {
      "iam": EnumToString.convertToString(iam),
      "iWannaMeet": EnumToString.convertToString(iWannaMeet),
      "relationType": EnumToString.convertToString(relationType)
    };
  }
}

enum Gender {
  male,
  female,
  spartan
}
