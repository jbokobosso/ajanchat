import 'package:ajanchat/constants/routes.dart';
import 'package:ajanchat/widgets/gradient_tile.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg.png'),
                  fit: BoxFit.cover
              )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Container(
              //     child: Provider.of<AuthProvider>(context).riveArtboard == null
              //         ? Text('')
              //         : Container(
              //             height: 100.0,
              //             child: Rive(
              //                 artboard: Provider.of<AuthProvider>(context).riveArtboard,
              //                 fit: BoxFit.contain
              //             )
              //           ),
              //     width: MediaQuery.of(context).size.width*0.7
              // ),
              const SizedBox(height: 50),
              Column(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, RouteNames.auth),
                    child: const GradientTile(
                      tileText: "S'inscrire",
                      tileAlignment: Alignment.centerLeft,
                      isBackgroundUnique: false,
                    ),
                  ),
                  SizedBox(height: 50),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, RouteNames.auth),
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

