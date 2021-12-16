import 'package:ajanchat/pages/auth/auth_page.dart';
import 'package:flutter/material.dart';

class RouteNames {
  static String auth = "/auth";
}

Map<String, Widget Function(BuildContext)> routes = <String, WidgetBuilder> {
  RouteNames.auth : (BuildContext context) => const AuthPage(),
};