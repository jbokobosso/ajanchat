class Globals {

  ///*  ***************************  * ***/
  ///   *          CORE             * ***/
  /// *  ***************************  * ***/
  static const int maximumAjanLimit = 1;
  static const String appName = "Ajan Chat";
  static const String appVersion = "1.0.0";
  static const String firebaseDevSmsCode = "012345";
  static const int maximumAgeInDays = 6570;
  static const int minimumAgeInDays = 29200;
  static const String deleteAccountWarningMessage = ""
      "Votre profil sera supprimé de notre base et vous ne pourrez plus le restaurer. Vous n'apparaitrez plus dans les recherches."
      "Vous pourrez toute-fois toujours revenir vous inscrire comme un nouveau membre.";





  ///*  ***************************  * ***/
  ///   *   FIREBASE STORAGE NAMES   * ***/
  /// *  ***************************  * ***/
  static const FSN_profile_pictures = "pictures/profile/";








  ///*  ***************************  * ***/
  ///   *   FIREBASE COLLECTION NAMES   * ***/
  /// *  ***************************  * ***/
  static const FCN_ajan = "ajan_profile";
  static const FDP_likedAjanList = "likedAjanList";
  static const FDP_dislikedAjanList = "dislikedAjanList";








  ///*  ***************************  * ***/
  ///   *   SHARED PREFERENCES KEYS   * ***/
  /// *  ***************************  * ***/
  static const S_isLogged = "isLogged";
  static const S_lastReadAjan = "last_read_ajan";
}
