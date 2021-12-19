import 'package:ajanchat/pages/auth/auth_page.dart';
import 'package:ajanchat/pages/auth/gender_page.dart';
import 'package:ajanchat/pages/auth/infos_page.dart';
import 'package:ajanchat/pages/auth/login_page.dart';
import 'package:ajanchat/pages/auth/phone_page.dart';
import 'package:ajanchat/pages/auth/pictures_page.dart';
import 'package:ajanchat/pages/auth/preferences_page.dart';
import 'package:ajanchat/pages/auth/register_page.dart';
import 'package:ajanchat/pages/tabs/chat/single_chat_page.dart';
import 'package:ajanchat/pages/tabs/tabs_page.dart';
import 'package:ajanchat/widgets/otp.dart';
import 'package:flutter/material.dart';

class RouteNames {
  static String auth = "/auth";
  static String otp = "/otp";
  static String register = "/register";
  static String login = "/login";
  static String phone = "/phone";
  static String infos = "/infos";
  static String gender = "/gender";
  static String preferences = "/preferences";
  static String pictures = "/pictures";
  static String tabs = "/tabs";
  static String singleChat = "/singleChat";
}

Map<String, Widget Function(BuildContext)> routes = <String, WidgetBuilder> {
  RouteNames.auth : (BuildContext context) => const AuthPage(),
  RouteNames.otp : (BuildContext context) => Otp("+228 99 88 58 25"),
  RouteNames.register : (BuildContext context) => const RegisterPage(),
  RouteNames.login : (BuildContext context) => const LoginPage(),
  RouteNames.phone : (BuildContext context) => const PhonePage(),
  RouteNames.infos : (BuildContext context) => const InfosPage(),
  RouteNames.gender : (BuildContext context) => const GenderPage(),
  RouteNames.preferences : (BuildContext context) => const PreferencesPage(),
  RouteNames.pictures : (BuildContext context) => const PicturesPage(),
  RouteNames.tabs : (BuildContext context) => const TabsPage(),
  RouteNames.singleChat : (BuildContext context) => const SingleChatPage(),
};