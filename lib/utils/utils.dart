import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {

  static int calculateAge(DateTime birthDate) {
    double value = DateTime.now().difference(birthDate).inDays/(365);
    return value.toInt();
  }

  static showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: const Color(0xffDF25AB),
      gravity: ToastGravity.CENTER,
      textColor: Colors.white,
      fontSize: 16.0
    );
  }

  static String getFirebaseErrorMessageByCode(String code) {
    String result = "";
    switch(code) {
      case 'session-expired':
        result = 'Le code SMS a expiré. Veuillez renvoyer le code de vérification pour réessayer.';
      break;
      case 'auth/user-not-found':
        result = 'Aucun utilisateur ne correspond à ce mail.';
      break;
      case 'auth/email-already-in-use':
        result = 'Cette adresse email est déjà utilisée.';
      break;
      case 'invalid-verification-code':
        result = 'Code invalide.';
      break;
    }
    return result;
  }

  static timestampToDateTime(Timestamp timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
  }

  static String formatDateToHuman(DateTime datetime) {
    String result;
    String yearMonth = "";
    String weekday = "";
    switch(datetime.weekday) {
      case 1 : weekday = "Lundi";break;
      case 2 : weekday = "Mardi";break;
      case 3 : weekday = "Mercredi";break;
      case 4 : weekday = "Jeudi";break;
      case 5 : weekday = "Vendredi";break;
      case 6 : weekday = "Samedi";break;
      case 7 : weekday = "Dimanche";break;
    }
    switch(datetime.month) {
      case 1: yearMonth = "Janvier";break;
      case 2: yearMonth = "Février";break;
      case 3: yearMonth = "Mars";break;
      case 4: yearMonth = "Avril";break;
      case 5: yearMonth = "Mai";break;
      case 6: yearMonth = "Juin";break;
      case 7: yearMonth = "Juillet";break;
      case 8: yearMonth = "Août";break;
      case 9: yearMonth = "Septembre";break;
      case 10: yearMonth = "Octobre";break;
      case 11: yearMonth = "Novembre";break;
      case 12: yearMonth = "Decembre";break;
    }
    result = "$weekday ${datetime.day.toString()} $yearMonth ${datetime.year.toString()}";
    return result;
  }

  static String formatTimeToHuman(TimeOfDay time) {
    return "${time.hour}:${time.minute}";
  }
}