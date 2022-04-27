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
  List<dynamic> likedAjanList = [];
  List<dynamic> dislikedAjanList = [];
  late DocumentSnapshot lastReadAjan;
  bool isBusy = true;

  HomeProvider() {
    likedAjanList.add(FirebaseAuth.instance.currentUser!.uid);
    dislikedAjanList.add(FirebaseAuth.instance.currentUser!.uid);
  }

  Future<AjanModel> getLoggedUserFromFirebase() async {
    var result = await FirebaseFirestore.instance.collection(Globals.FCN_ajan)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    return AjanModel.fromMap(result.data()!, result.id);
  }

  getAjanList() async {
    try {
      if(ajanList.isNotEmpty) return;
      List<AjanModel> ajanListTemp = [];

      List<dynamic> ajanToExlude = [];
      ajanToExlude.addAll(likedAjanList);
      ajanToExlude.addAll(dislikedAjanList);
      AjanModel _loggedUser = await getLoggedUserFromFirebase();
      ajanToExlude.addAll(_loggedUser.dislikedAjanList);
      ajanToExlude.addAll(_loggedUser.likedAjanList);

      QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore.instance
          .collection(Globals.FCN_ajan)
          .where("id", whereNotIn: ajanToExlude)
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
    try {
      isBusy = true;
      notifyListeners();
      // likedAjanList = [FirebaseAuth.instance.currentUser!.uid]; // reset data for not using old uneeded data because surely already updated on firebase
      // dislikedAjanList = [FirebaseAuth.instance.currentUser!.uid];
      List<AjanModel> ajanListTemp =[];

      List<dynamic> ajanToExlude = [];
      ajanToExlude.addAll(likedAjanList);
      ajanToExlude.addAll(dislikedAjanList);

      QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore.instance
          .collection(Globals.FCN_ajan)
          .where("id", whereNotIn: ajanToExlude)
          .orderBy("id")
          .orderBy("createdAt")
          .where("isActive", isEqualTo: true)
          // .startAfter([lastReadAjan.data()])
          .limit(Globals.maximumAjanLimit)
          .get();
      for (var queryDocumentSnapshot in data.docs) {
        ajanListTemp.add(
            AjanModel.fromMap(queryDocumentSnapshot.data(), queryDocumentSnapshot.id)
        );
      }
      ajanList = ajanListTemp;
    } catch(exception) {
      rethrow;
    } finally {
      isBusy = false;
      notifyListeners();
    }
  }

  likeAjan(BuildContext context, AjanModel likedAjan) {
    likedAjanList.add(likedAjan.id);
    ajanList.remove(likedAjan);
    updateLikedAjanOnFirebase(context);

    checkIfAjanListIsEmpty();
  }

  dislikeAjan(BuildContext context, AjanModel dislikedAjan) {
    dislikedAjanList.add(dislikedAjan.id);
    ajanList.remove(dislikedAjan);
    updateDislikedAjanOnFirebase(context);

    checkIfAjanListIsEmpty();
  }

  checkIfAjanListIsEmpty() {
    if(ajanList.isEmpty) getAdditionalAjanList();
  }

  updateLikedAjanOnFirebase(BuildContext context) {
    FirebaseFirestore.instance
        .collection(Globals.FCN_ajan)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({Globals.FDP_likedAjanList: FieldValue.arrayUnion(likedAjanList)})
        .then((value) => Utils.showToast("Liké !"))
        .catchError((onError) => throw onError);
  }

  updateDislikedAjanOnFirebase(BuildContext context) {
    FirebaseFirestore.instance
        .collection(Globals.FCN_ajan)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({Globals.FDP_dislikedAjanList: FieldValue.arrayUnion(dislikedAjanList)})
        .then((value) => Utils.showToast("Pas aimé !"))
        .catchError((onError) => throw onError);
  }
}