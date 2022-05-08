import 'dart:ffi';
import 'dart:io';

import 'package:ajanchat/constants/ajan_preferences.dart';
import 'package:ajanchat/constants/file_assets.dart';
import 'package:ajanchat/constants/globals.dart';
import 'package:ajanchat/constants/routes.dart';
import 'package:ajanchat/constants/shared_preferences.dart';
import 'package:ajanchat/models/ERelationType.dart';
import 'package:ajanchat/models/PreferenceModel.dart';
import 'package:ajanchat/models/RelationPreferences.dart';
import 'package:ajanchat/models/ajan_model.dart';
import 'package:ajanchat/models/image_card_model.dart';
import 'package:ajanchat/models/place_model.dart';
import 'package:ajanchat/utils/utils.dart';
import 'package:ajanchat/widgets/info_alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {

  AjanModel defaultUser = AjanModel(
      phoneNumber: "",
      preferences: [],
      images: [],
      birthDate: DateTime.fromMicrosecondsSinceEpoch(1000),
      relationPreferences: RelationPreferences(
        iam: Gender.spartan,
        iWannaMeet: Gender.spartan,
        relationType: ERelationType.spartan
      ),
      dislikedAjanList: [],
      likedAjanList: [],
      inRelationAjanList: []
  );
  AjanModel signupAjan = AjanModel(
      phoneNumber: "",
      preferences: [],
      images: [],
      birthDate: DateTime.fromMicrosecondsSinceEpoch(1000),
      relationPreferences: RelationPreferences(
        iam: Gender.spartan,
        iWannaMeet: Gender.spartan,
        relationType: ERelationType.spartan
      ),
      dislikedAjanList: [],
      likedAjanList: [],
      inRelationAjanList: []
  );
  AjanModel loggedUser = AjanModel(
    phoneNumber: "",
    preferences: [],
    images: [],
    birthDate: DateTime.fromMicrosecondsSinceEpoch(1000),
    relationPreferences: RelationPreferences(
      iam: Gender.spartan,
      iWannaMeet: Gender.spartan,
      relationType: ERelationType.spartan
    ),
      dislikedAjanList: [],
      likedAjanList: [],
      inRelationAjanList: []
  );
  bool isBusy = false;
  String errorMessage  = "";
  String otpErrorMessage = "";
  late BuildContext authBuildContext;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  RelationPreferences genderPreference = RelationPreferences(iam: Gender.spartan, iWannaMeet: Gender.spartan, relationType: ERelationType.spartan);
  List<PreferenceModel> preferences = availablePreferences;
  List<ImageCardModel> images = [
    ImageCardModel(image: File("")),
    ImageCardModel(image: File("")),
    ImageCardModel(image: File("")),
    ImageCardModel(image: File("")),
    ImageCardModel(image: File("")),
    ImageCardModel(image: File(""))
  ];
  final picker = ImagePicker();
  var currentTabIndex = 0;
  PhoneNumber phoneNumberInput = PhoneNumber(dialCode: '+1', phoneNumber: '0');

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController birthdateController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  DateTime birthdateValue = DateTime(2021);
  PlaceModel locationValue = PlaceModel(0, 0);

  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> infosFormKey = GlobalKey<FormState>();
  double uploadPercentage = 0;
  bool isUploading = false;
  bool isLocating = false;
  bool isLoggingOut = false;
  int currentUploadingImageCount = 1;

  getAjanListImages(String ajanUid)  async {
    List<dynamic> imagesDownloadUrls = [];
    ListResult listResult = await FirebaseStorage.instance.ref(Globals.FSN_profile_pictures).child(ajanUid).list();
    for (var element in listResult.items) {
      imagesDownloadUrls.add(await element.getDownloadURL());
    }
    return imagesDownloadUrls;
  }

  setImages(List<dynamic> existingNetworkImages) {
    int i=0;
    int j=0;
    for(dynamic image in images) {
      images[j].networkImage = "";
      j++;
    }

    for(dynamic networkImage in existingNetworkImages) {
      images[i].networkImage = networkImage;
      i++;
    }
    if (kDebugMode) {
      print(images);
    }
    notifyListeners();
  }

  setPreferences(List<dynamic> newStringPrefs) {
    for(dynamic newPref in newStringPrefs) {
      int i=0;
      for(PreferenceModel preferenceModel in preferences) {
        if(preferenceModel.label == newPref.toString()) {
          preferences[i].isChosen = true;
        }
        i++;
      }
    }
    if (kDebugMode) {
      print(preferences);
    }
    notifyListeners();
  }

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
    isBusy = false;
    notifyListeners();
    navigateTo(authBuildContext, RouteNames.otp, arguments: params);
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

  void selectGender(Gender gender) {
    switch(gender) {
      case Gender.female:
        genderPreference.iam = gender;
        break;
      case Gender.male:
        genderPreference.iam = gender;
        break;
      default:
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
      default:
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
      default:
        genderPreference.relationType = relationType;
        break;
    }
    notifyListeners();
  }

  void selectOrUnselectPreference(int index) {
    preferences[index].isChosen = !preferences[index].isChosen;
    notifyListeners();
  }

  Future<void> pickImage(int index, BuildContext buildContext) async {

    pickFile(ImageSource imageSource) async {
      final pickedFile = await picker.getImage(source: imageSource, maxWidth: 300, maxHeight: 300);
      if (pickedFile != null) {
        images[index].image = File(pickedFile.path);
        images[index].isFilled = true;
        notifyListeners();
      } else {
        Utils.showToast("Acune image sélecionnée !");
      }
      notifyListeners();
      Navigator.of(buildContext).pop();
    }

    showModalBottomSheet(
        context: buildContext,
        builder: (buildContext) => SizedBox(
          height: MediaQuery.of(buildContext).size.height*0.2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Choisir Photo", style: TextStyle(fontSize: 20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      IconButton(
                          icon: const Icon(Icons.camera, size: 40),
                          onPressed: () => pickFile(ImageSource.camera)
                      ),
                      const Text("Caméra")
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                          icon: const Icon(Icons.photo, size: 40),
                          onPressed: () => pickFile(ImageSource.gallery)
                      ),
                      const Text("Gallerie")
                    ],
                  )
                ],
              )
            ],
          ),
        )
    );


    // final pickedFile = await picker.getImage(source: ImageSource.gallery);
    // if (pickedFile != null) {
    //   images[index].image = File(pickedFile.path);
    //   images[index].isFilled = true;
    //   notifyListeners();
    // } else {
    //   Utils.showToast("Acune image sélecionnée !");
    // }
    // notifyListeners();
  }

  void clearPictures(int index) {
    images[index].isFilled = false;
    images[index].image = File("");
    images[index].networkImage = "";
    notifyListeners();
  }

  void changeTabIndex(int newIndex) {
    currentTabIndex = newIndex;
    notifyListeners();
  }

  void onInfosFormSaved(BuildContext context) async {
    bool isValid = infosFormKey.currentState!.validate();
    if(isValid) {
      signupAjan.displayName = "${firstnameController.text.trim()} ${lastnameController.text.toUpperCase().trim()}";
      signupAjan.birthDate = birthdateValue;
      signupAjan.location = locationValue;
      Navigator.pushNamed(context, RouteNames.gender);
    }
    if (kDebugMode) {
      print(signupAjan);
    }
  }

  Future<void> onLocationTapped() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    isLocating = true;
    notifyListeners();
    _locationData = await location.getLocation();
    isLocating = false;
    notifyListeners();
    locationValue.latitude = _locationData.latitude!;
    locationValue.longitude = _locationData.longitude!;
    locationController.text = "${locationValue.latitude}, ${locationValue.longitude}";
    notifyListeners();
  }

  void onGenderFormSaved(BuildContext context) {
    if(genderPageIsValid(context)) {
      signupAjan.relationPreferences!.iam = genderPreference.iam;
      signupAjan.relationPreferences!.iWannaMeet = genderPreference.iWannaMeet;
      signupAjan.relationPreferences!.relationType = genderPreference.relationType;
      Navigator.pushNamed(context, RouteNames.preferences);
      if (kDebugMode) {
        print(signupAjan);
      }
    } else {
      showDialog(context: context, builder: (_) => InfoAlert("Veuillez remplir tous les champs", imageAsset: FileAssets.crossIcon));
    }
  }
  
  void onPreferencesFormSaved(BuildContext context) {
    signupAjan.preferences = preferences.where((element) => element.isChosen == true).map((e) => e.label).toList();
    Navigator.of(context).pushNamed(RouteNames.pictures);
    if (kDebugMode) {
      print(signupAjan);
    }
  }

  Future<void> onUpdatePreferences(BuildContext context) async {
    isBusy = true;
    notifyListeners();
    try {
      List<dynamic> newPreferencesList = preferences.where((element) => element.isChosen == true).map((e) => e.label).toList();
      await FirebaseFirestore.instance
          .collection(Globals.FCN_ajan)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'preferences': newPreferencesList
      });
      loadLoggedUserFromFirebaseAndNotify();
      Navigator.pop(context);
    } catch(e) {
      rethrow;
    } finally {
      isBusy = false;
      notifyListeners();
    }
  }

  Future<void> onUpdatePicturesFormSaved(BuildContext context) async {
    signupAjan.images = images.where((element) => element.isFilled == true && element.networkImage.isEmpty).map((e) => e.image.path).toList();
    if (kDebugMode) {
      print(signupAjan);
    }
    var networkFilledCount = images.length - signupAjan.images.length;
    // uploadProfilePictures(alreadyFilledCount: networkFilledCount);
    await uploadUpdatedProfilePictures();
  }

  void onPicturesFormSaved(BuildContext context) {
    signupAjan.images = images.where((element) => element.isFilled == true).map((e) => e.image.path).toList();
    if (kDebugMode) {
      print(signupAjan);
    }
    signupUser(context);
  }

  signupUser(BuildContext context) async {
    isBusy = true;
    notifyListeners();
    try {
      notifyListeners();
      await uploadProfilePictures();
      storeUserOnFirebase();
      await markUserLogged();
      Navigator.of(context).pushNamedAndRemoveUntil(RouteNames.tabs, (route) => false);
    } catch(exception) {
      rethrow;
    } finally {
      isBusy = false;
      notifyListeners();
    }
  }

  logout(BuildContext buildContext) async {
    isLoggingOut = true;
    notifyListeners();
    try {
      FirebaseAuth.instance.signOut();
      loggedUser = defaultUser;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(Globals.S_isLogged, false);
      Navigator.of(buildContext).pushNamedAndRemoveUntil(RouteNames.auth, (route) => false);
      Utils.showToast("Déconnecté !");
    } catch(exception) {
      rethrow;
    } finally {
      isLoggingOut = false;
      notifyListeners();
    }
  }

  deleteAccountAndLogout(BuildContext buildContext) {
    isLoggingOut = true;
    notifyListeners();
    try {
      FirebaseStorage.instance
          .ref(Globals.FSN_profile_pictures)
          .child(FirebaseAuth.instance.currentUser!.uid)
          .delete()
          .then((value) => Utils.showToast("Images supprimées"));
      FirebaseFirestore.instance
          .collection(Globals.FCN_ajan)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .delete()
          .then((value) async {
            FirebaseAuth.instance.signOut();
            loggedUser = defaultUser;
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool(Globals.S_isLogged, false);
            Navigator.of(buildContext).pushNamedAndRemoveUntil(RouteNames.auth, (route) => false);
            Utils.showToast("Compte supprimé !");
          });
    } catch(exception) {
      rethrow;
    } finally {
      isLoggingOut = false;
      notifyListeners();
    }
  }

  Future<void> loadLoggedUserFromFirebase() async {
    FirebaseFirestore.instance.collection(Globals.FCN_ajan)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      loggedUser = AjanModel.fromMap(value.data()!, value.id);
      if(kDebugMode) print(loggedUser);
    });
  }

  Future<void> loadLoggedUserFromFirebaseAndNotify() async {
    FirebaseFirestore.instance.collection(Globals.FCN_ajan)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      loggedUser = AjanModel.fromMap(value.data()!, value.id);
      loggedUser.images = await getAjanListImages(FirebaseAuth.instance.currentUser!.uid);
      Utils.showToast("Utilisateur chargé");
      notifyListeners();
    });
  }

  Future<bool> checkUserIsLogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool condition1 =  prefs.getBool(Globals.S_isLogged) ?? false;

    bool condition2 = false;
    if(FirebaseAuth.instance.currentUser != null) {
      var data = await FirebaseFirestore.instance.collection(Globals.FCN_ajan).doc(FirebaseAuth.instance.currentUser!.uid).get();
      condition2 = data.exists;
    }

    return condition1 || condition2;
  }

  Future<bool> markUserLogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result = await prefs.setBool(Globals.S_isLogged, true);
    return result;
  }

  void storeUserOnFirebase() {
    signupAjan.id = FirebaseAuth.instance.currentUser!.uid;
    // The two following lines are to prevent showing self profile on ajan list.
    // It also initializes the concerned arrays as filter based on them must not be with empty array
    signupAjan.dislikedAjanList.add(FirebaseAuth.instance.currentUser!.uid);
    signupAjan.likedAjanList.add(FirebaseAuth.instance.currentUser!.uid);
    FirebaseFirestore
        .instance
        .collection(Globals.FCN_ajan)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(signupAjan.toMap());
  }

  Future<void> uploadProfilePictures() async {
    currentUploadingImageCount = 1; // initialize in case it's called multiple times
    for (var imagePath in signupAjan.images) {
      isUploading = true;
      Stream<TaskSnapshot> taskStream = FirebaseStorage.instance
          .ref(Globals.FSN_profile_pictures)
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child( "$currentUploadingImageCount.${imagePath.split("/").last.toString().split('.').last}" )
          .putFile(File(imagePath))
          .snapshotEvents;

      await for (TaskSnapshot taskSnapshot in taskStream) {
        print("$uploadPercentage -- ${taskSnapshot.bytesTransferred} -- ${taskSnapshot.totalBytes}");
        uploadPercentage = (taskSnapshot.bytesTransferred*100)/taskSnapshot.totalBytes;
        notifyListeners();
        if(uploadPercentage == 100) {
          break;
        }
      }

      isUploading = false;
      notifyListeners();
      Utils.showToast("Image ${currentUploadingImageCount} téléversée !");
      currentUploadingImageCount++;
    }
  }

  Future<void> uploadUpdatedProfilePictures() async {
    currentUploadingImageCount = 1; // initialize in case it's called multiple times
    for (ImageCardModel imageCardModel in images) {
      if(imageCardModel.isFilled && imageCardModel.networkImage.isEmpty) {
        isUploading = true;
        Stream<TaskSnapshot> taskStream = FirebaseStorage.instance
            .ref(Globals.FSN_profile_pictures)
            .child(FirebaseAuth.instance.currentUser!.uid)
            .child( "$currentUploadingImageCount.${imageCardModel.image.path.split("/").last.toString().split('.').last}")
            .putFile(imageCardModel.image)
            .snapshotEvents;

        await for (TaskSnapshot taskSnapshot in taskStream) {
          uploadPercentage = (taskSnapshot.bytesTransferred*100)/taskSnapshot.totalBytes;
          notifyListeners();
          if(uploadPercentage == 100) {
            String uploadedUrl = await taskSnapshot.ref.getDownloadURL();
            break;
          }
        }

        isUploading = false;
        notifyListeners();
        Utils.showToast("Image $currentUploadingImageCount téléversée !");


      }
      currentUploadingImageCount++; // even if an image is skipped, count anyway so that naming will work
    }
  }

  bool genderPageIsValid(BuildContext context) {
    if(genderPreference.iam == genderPreference.iWannaMeet && genderPreference.iam != Gender.spartan) {
      showDialog(context: context, builder: (_) => InfoAlert("Vous avez choisi une mauvaise préférence de genre", lottieAsset: FileAssets.lottieAstonished, title: "Erreur !".toUpperCase(),));
      return false;
    }
    if(genderPreference.iam == Gender.spartan || genderPreference.iWannaMeet == Gender.spartan || genderPreference.relationType == ERelationType.spartan) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> updateProfileName(String newDisplayName) async {
    bool result = false;
    isBusy = true;
    notifyListeners();
    try {
      await FirebaseFirestore.instance
          .collection(Globals.FCN_ajan)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'displayName': newDisplayName
      });
      loggedUser.displayName = newDisplayName;
      result = true;
    } catch (exception) {
      result = false;
      debugPrint(exception.toString());
    } finally {
      isBusy = false;
      notifyListeners();
    }

    return result;
  }

  Future<bool> updateBirthdate(DateTime newBirthdate) async {
    bool result = false;
    isBusy = true;
    notifyListeners();
    try {
      await FirebaseFirestore.instance
          .collection(Globals.FCN_ajan)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
            'birthDate': newBirthdate
          });
      loggedUser.birthDate = newBirthdate;
      result = true;
    } catch (exception) {
      result = false;
      debugPrint(exception.toString());
    } finally {
      isBusy = false;
      notifyListeners();
    }

    return result;
  }
}