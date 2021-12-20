import 'dart:io';

import 'package:ajanchat/constants/ajan_preferences.dart';
import 'package:ajanchat/constants/routes.dart';
import 'package:ajanchat/constants/shared_preferences.dart';
import 'package:ajanchat/models/ERelationType.dart';
import 'package:ajanchat/models/PreferenceModel.dart';
import 'package:ajanchat/models/RelationPreferences.dart';
import 'package:ajanchat/models/ajan_model.dart';
import 'package:ajanchat/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {

  AjanModel signupAjan = AjanModel(phoneNumber: "", preferences: [], images: [], birthDate: DateTime.fromMicrosecondsSinceEpoch(1000));
  bool isBusy = false;
  String errorMessage  = "";
  String otpErrorMessage = "";
  late BuildContext authBuildContext;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  RelationPreferences genderPreference = RelationPreferences(iam: Gender.spartan, iWannaMeet: Gender.spartan, relationType: ERelationType.spartan);
  List<PreferenceModel> preferences = availablePreferences;
  late File image = File("");
  List<File> images = [];
  final picker = ImagePicker();
  var currentTabIndex = 0;
  PhoneNumber phoneNumberInput = PhoneNumber(dialCode: '+1', phoneNumber: '0');
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  void onRegisterFormSaved(BuildContext context) async {
    isBusy = true;
    notifyListeners();
    authBuildContext = context;
    bool isValid = registerFormKey.currentState!.validate();
    if(isValid) await authenticateByFirebase(phoneNumberInput.toString());
    notifyListeners();
  }

  Future<void> authenticateByFirebase(String phoneNumber) async {
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: onPhoneVerificationCompleted,
      verificationFailed: onPhoneVerificationFailed,
      codeSent: onCodeSent,
      codeAutoRetrievalTimeout: onCodeAutoRetrievalTimeout
    );
  }

  Future<void> onPhoneVerificationCompleted(PhoneAuthCredential authCredential) async {
    // try {
    //   await firebaseAuth.signInWithCredential(authCredential);
    // } catch (e) {
    //   errorMessage = "Erreur durant l'authentification Firebase. Veuillez reéssayer.\n Code Erreur: 117-1";
    //   if(kDebugMode) print(e);
    //   isBusy = false;
    //   notifyListeners();
    // }
    // bool success = await markAuthenticated();
    // if(success) {
    //   signupAjan.phoneNumber = phoneNumberInput as String;
    //   signupAjan.createdAt = DateTime.now();
    //   Utils.showToast("Numéro vérifié !");
    //   navigateTo(authBuildContext, RouteNames.infos);
    // } else {
    //   errorMessage = "Impossible de marquer en local que l'user s'est authentifié. Veuillez reéssayer\n Code Erreur: 117-0";
    //   isBusy = false;
    //   notifyListeners();
    // }
  }

  void onPhoneVerificationFailed(FirebaseAuthException firebaseAuthException) {
    if(firebaseAuthException.code == 'invalid-phone-number') {
      errorMessage = "Format de numéro de téléphone incorrect.";
    } else {
      errorMessage = firebaseAuthException.message!;
    }
    isBusy = false;
    notifyListeners();
  }

  void onCodeSent(String code, int? resendToken) {
    Map<String, String> params = {
      "code": code,
      "phoneNumber": phoneNumberInput.toString(),
      "resendToken": resendToken.toString()
    };
    navigateTo(authBuildContext, RouteNames.otp, arguments: params);
  }

  void onCodeAutoRetrievalTimeout(String verificationId) {

  }

  void navigateTo(BuildContext context, String routeName, {dynamic arguments = 117}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  Future<bool> markAuthenticated() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(S_isAuthenticated, true);
  }

  Future<bool> checkAuthenticated() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? result = prefs.getBool(S_isAuthenticated);
    if(result == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> verifyCodeSentManually(String verificationId, String userTypedCode) async {
    try {
      isBusy = true;
      notifyListeners();
      AuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: userTypedCode);
      UserCredential userCredential = await firebaseAuth.signInWithCredential(credential);
      bool success = await markAuthenticated();
      if(success) {
        signupAjan.phoneNumber = phoneNumberInput.toString();
        signupAjan.createdAt = DateTime.now();
        return true;
      } else {
        otpErrorMessage = "Impossible de marquer en local que l'user s'est authentifié. Veuillez reéssayer\n Code Erreur: 117-0";
        notifyListeners();
        return false;
      }
    } on FirebaseAuthException catch (_, e) {
      otpErrorMessage = Utils.getFirebaseErrorMessageByCode(_.code);
      return false;
    } finally {
      isBusy = false;
    }
  }

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