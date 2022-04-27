import 'package:ajanchat/constants/file_assets.dart';
import 'package:ajanchat/constants/globals.dart';
import 'package:ajanchat/models/ERelationType.dart';
import 'package:ajanchat/models/RelationPreferences.dart';
import 'package:ajanchat/models/ajan_model.dart';
import 'package:ajanchat/providers/auth_provider.dart';
import 'package:ajanchat/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider extends ChangeNotifier {
  List<AjanModel> ajanList = [];
  List<AjanModel> likedAjanList = [];
  List<AjanModel> dislikedAjanList = [];
  late DocumentSnapshot lastReadAjan;
  bool isBusy = true;
  final AuthProvider _authProvider = AuthProvider();

  getAjanList() async {
    try {
      if(ajanList.isNotEmpty) return;
      List<AjanModel> ajanListTemp = [];
      QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore.instance
          .collection(Globals.FCN_ajan)
          .where("id", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .orderBy("id")
          .orderBy("createdAt")
          .where("isActive", isEqualTo: true)
          .limit(Globals.maximumAjanLimit)
          .get();
      for (var queryDocumentSnapshot in data.docs) {
        ajanListTemp.add(
            AjanModel.fromMap(queryDocumentSnapshot.data(), queryDocumentSnapshot.id)
        );
      }
      ajanList = ajanListTemp;
      if(data.docs.isNotEmpty) lastReadAjan = data.docs.last;
    } catch(exception) {
      rethrow;
    } finally {
      isBusy = false;
      notifyListeners();
      if(ajanList.isEmpty) Utils.showToast("Base de donnée vide!");
    }
  }

  getAdditionalAjanList() async {
    isBusy = true;
    notifyListeners();
    try {
      List<AjanModel> ajanListTemp =[];
      QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore.instance
          .collection(Globals.FCN_ajan)
          .where("id", whereNotIn: _authProvider.loggedUser.likedAjanList)
          .where("id", whereNotIn: _authProvider.loggedUser.dislikedAjanList)
          .orderBy("id")
          .orderBy("createdAt")
          .where("isActive", isEqualTo: true)
          .startAfter([lastReadAjan.data()])
          .limit(Globals.maximumAjanLimit)
          .get();
      data.docs.forEach((QueryDocumentSnapshot<Map<String, dynamic>> queryDocumentSnapshot) {
        ajanListTemp.add(
            AjanModel.fromMap(queryDocumentSnapshot.data(), queryDocumentSnapshot.id)
        );
      });
      ajanList = ajanListTemp;
    } catch(exception) {
      rethrow;
    } finally {
      isBusy = false;
      notifyListeners();
    }
  }

  likeAjan(BuildContext context, AjanModel likedAjan) {
    Provider.of<AuthProvider>(context, listen: false).loggedUser.likedAjanList.add(likedAjan.id);
    ajanList.remove(likedAjan);
    if(kDebugMode) { // saving writes in production: updating database only after ten likes
      if(Provider.of<AuthProvider>(context, listen: false).loggedUser.likedAjanList.isNotEmpty) updateLikedAjanOnFirebase(context);
    } else {
      if(likedAjanList.length == Globals.maximumAjanLimit) updateLikedAjanOnFirebase(context);
    }

    // checkIfAjanListIsEmpty();
  }

  dislikeAjan(BuildContext context, AjanModel dislikedAjan) {
    Provider.of<AuthProvider>(context, listen: false).loggedUser.dislikedAjanList.add(dislikedAjan.id);
    ajanList.remove(dislikedAjan);
    if(kDebugMode) { // saving writes in production: updating database only after ten likes
      if(Provider.of<AuthProvider>(context, listen: false).loggedUser.dislikedAjanList.isNotEmpty) updateDislikedAjanOnFirebase(context);
    } else {
      if(likedAjanList.length == Globals.maximumAjanLimit) updateDislikedAjanOnFirebase(context);
    }

    // checkIfAjanListIsEmpty();
  }

  checkIfAjanListIsEmpty() {
    if(ajanList.isEmpty) getAdditionalAjanList();
  }

  updateLikedAjanOnFirebase(BuildContext context) {
    FirebaseFirestore.instance
        .collection(Globals.FCN_ajan)
        .doc(Provider.of<AuthProvider>(context, listen: false).loggedUser.id)
        .update({Globals.FDP_likedAjanList: FieldValue.arrayUnion(Provider.of<AuthProvider>(context, listen: false).loggedUser.likedAjanList)})
        .then((value) => Utils.showToast("Liké !"))
        .catchError((onError) => throw onError);
  }

  updateDislikedAjanOnFirebase(BuildContext context) {
    FirebaseFirestore.instance
        .collection(Globals.FCN_ajan)
        .doc(Provider.of<AuthProvider>(context, listen: false).loggedUser.id)
        .update({Globals.FDP_dislikedAjanList: FieldValue.arrayUnion(Provider.of<AuthProvider>(context, listen: false).loggedUser.dislikedAjanList)})
        .then((value) => Utils.showToast("Pas aimé !"))
        .catchError((onError) => throw onError);
  }
}