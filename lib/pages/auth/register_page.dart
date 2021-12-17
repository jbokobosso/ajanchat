import 'package:ajanchat/constants/routes.dart';
import 'package:ajanchat/widgets/curved_top_background.dart';
import 'package:ajanchat/widgets/custom_app_bar.dart';
import 'package:ajanchat/widgets/gradient_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  double clipBarSizeScale = 2;

  double titleBottomSpacingScale = 2;

  double formHeightScale = 2;

  double textInputSpacingScale = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(),
        body: ListView(
          padding: EdgeInsets.all(0),
          children: [
            CurvedTopBackground(
              deviceHeight: MediaQuery.of(context).size.height, 
              clipBarSizeScale: clipBarSizeScale
            ),
            Align(
                alignment: Alignment.center,
                child: Text("S'inscrire", style: Theme.of(context).textTheme.headline6)
            ),
            SizedBox(height: MediaQuery.of(context).size.height*titleBottomSpacingScale),
            Form(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height*this.formHeightScale,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                            icon: SvgPicture.asset('assets/icons/profile.svg'),
                            labelText: 'Nom',
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.deepPurple,
                                    width: 5.0,
                                    style: BorderStyle.solid
                                )
                            )
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*textInputSpacingScale),
                      TextFormField(
                        decoration: InputDecoration(
                            icon: SvgPicture.asset('assets/icons/profile.svg'),
                            labelText: 'Prénom',
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.deepPurple,
                                    width: 5.0,
                                    style: BorderStyle.solid
                                )
                            )
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*textInputSpacingScale),
                      TextFormField(
                        decoration: InputDecoration(
                            icon: SvgPicture.asset('assets/icons/calendar.svg'),
                            labelText: 'Date de naissance',
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.deepPurple,
                                    width: 5.0,
                                    style: BorderStyle.solid
                                )
                            )
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*textInputSpacingScale),
                      TextFormField(
                        decoration: InputDecoration(
                            icon: SvgPicture.asset('assets/icons/location.svg'),
                            labelText: 'Localisation',
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.deepPurple,
                                    width: 5.0,
                                    style: BorderStyle.solid
                                )
                            )
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*textInputSpacingScale),
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(RouteNames.gender),
              child: const GradientTile(
                tileAlignment: Alignment.centerRight,
                tileText: 'Continuer',
              ),
            )
          ],
        )
    );
  }
}
