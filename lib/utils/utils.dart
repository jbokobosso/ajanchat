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
}