import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BottomNavigationProvider extends ChangeNotifier {

  int currentTabIndex = 0;

  void changeTabIndex(int newIndex) {
    currentTabIndex = newIndex;
    notifyListeners();
  }
}