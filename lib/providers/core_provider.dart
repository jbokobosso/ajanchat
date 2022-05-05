import 'package:ajanchat/providers/auth_provider.dart';
import 'package:ajanchat/providers/chat_provider.dart';
import 'package:flutter/cupertino.dart';

class CoreProvider extends ChangeNotifier {
  AuthProvider authProvider = AuthProvider();
  ChatProvider chatProvider = ChatProvider();
}