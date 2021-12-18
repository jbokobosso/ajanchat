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
}