import 'package:ajanchat/constants/file_assets.dart';
import 'package:ajanchat/constants/routes.dart';
import 'package:ajanchat/providers/auth_provider.dart';
import 'package:ajanchat/utils/utils.dart';
import 'package:ajanchat/widgets/gradient_tile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  @override
  void initState() {
    super.initState();
    checkUserIsLogged();
  }

  Future<void> checkUserIsLogged() async {
    bool userIsLogged = await Provider.of<AuthProvider>(context, listen: false).checkUserIsLogged();
    if(userIsLogged) {
      Utils.showToast("Bienvenue !");
      Navigator.of(context).pushNamedAndRemoveUntil(RouteNames.tabs, (Route route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(FileAssets.bgImage),
                  fit: BoxFit.cover
              )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  child: Container(
                          height: 100.0,
                          child: RiveAnimation.asset(FileAssets.riveLogoAnimation)
                        ),
                  width: MediaQuery.of(context).size.width*0.7
              ),
              const SizedBox(height: 50),
              Column(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, RouteNames.phone),
                    child: const GradientTile(
                      tileText: "S'inscrire",
                      tileAlignment: Alignment.centerLeft,
                      isBackgroundUnique: false,
                    ),
                  ),
                  SizedBox(height: 50),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, RouteNames.phone),
                    child: const GradientTile(
                      tileText: 'Se connecter',
                      tileAlignment: Alignment.centerRight,
                      isBackgroundUnique: false,
                    ),
                  ),
                ],
              )
            ],
          ),
        )
    );
  }
}

