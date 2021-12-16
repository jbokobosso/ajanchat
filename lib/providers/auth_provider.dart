import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class AuthProvider extends ChangeNotifier {
  late Artboard riveArtboard;
  RiveAnimationController controller = SimpleAnimation('discover');
}