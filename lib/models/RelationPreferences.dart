
class RelationPreferences {
  Gender iam;
  Gender iWannaMeet;
  RelationType relationType;

  RelationPreferences({
    required this.iam,
    required this.iWannaMeet,
    required this.relationType
  });
}

enum Gender {
  Homme,
  Femme
}

enum RelationType {
  Amicale,
  Serieuse,
  Flirt
}
