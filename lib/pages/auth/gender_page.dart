import 'package:ajanchat/constants/file_assets.dart';
import 'package:ajanchat/constants/routes.dart';
import 'package:ajanchat/models/RelationPreferences.dart';
import 'package:ajanchat/providers/auth_provider.dart';
import 'package:ajanchat/widgets/curved_top_background.dart';
import 'package:ajanchat/widgets/gradient_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class GenderPage extends StatefulWidget {
  const GenderPage({Key? key}) : super(key: key);

  @override
  _GenderPageState createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {

  double topCurvedHeightScale = 0.2;
  double formHeightScale = 0.6;
  double textInputSpacingScale = 0.05;

  final double tileScale = 0.04;
  final double tileFontScale = 0.03;

  @override
  Widget build(BuildContext context) {

    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: SvgPicture.asset(FileAssets.backArrowIcon),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*(topCurvedHeightScale)),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Tu es", style: Theme.of(context).textTheme.headline6),
                    SizedBox(height: 20),
                    SizedBox(
                      height: deviceHeight*tileScale,
                      child: GestureDetector(
                          onTap: () => Provider.of<AuthProvider>(context).selectGender(Gender.Homme),
                          child: GradientTile(
                            fontSizeScale: tileFontScale,
                            isBackgroundUnique: Provider.of<AuthProvider>(context).genderPreference.iam == Gender.Homme ? true : false,
                            tileAlignment: Alignment.centerLeft,
                            tileText: 'Homme',
                          )
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: deviceHeight*tileScale,
                      child: GestureDetector(
                          onTap: () => Provider.of<AuthProvider>(context).selectGender(Gender.Femme),
                          child: GradientTile(
                            fontSizeScale: tileFontScale,
                            isBackgroundUnique: Provider.of<AuthProvider>(context).genderPreference.iam == Gender.Femme ? true : false,
                            tileAlignment: Alignment.centerRight,
                            tileText: 'Femme',
                          )
                      ),
                    ),
                    SizedBox(height: 10),
                    Text("Tu veux rencontrer", style: Theme.of(context).textTheme.headline6),
                    SizedBox(height: 10),
                    SizedBox(
                      height: deviceHeight*tileScale,
                      child: GestureDetector(
                          onTap: () => Provider.of<AuthProvider>(context).selectPartnerGender(Gender.Homme),
                          child: GradientTile(
                            fontSizeScale: tileFontScale,
                            isBackgroundUnique: Provider.of<AuthProvider>(context).genderPreference.iWannaMeet == Gender.Homme ? true : false,
                            tileAlignment: Alignment.centerLeft,
                            tileText: 'Homme',
                          )
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: deviceHeight*tileScale,
                      child: GestureDetector(
                          onTap: () => Provider.of<AuthProvider>(context).selectPartnerGender(Gender.Femme),
                          child: GradientTile(
                            fontSizeScale: tileFontScale,
                            isBackgroundUnique: Provider.of<AuthProvider>(context).genderPreference.iWannaMeet == Gender.Femme ? true : false,
                            tileAlignment: Alignment.centerRight,
                            tileText: 'Femme',
                          )
                      ),
                    ),
                    SizedBox(height: 10),
                    Text("Tu es ici pour une relation", style: Theme.of(context).textTheme.headline6),
                    SizedBox(height: 30),
                    SizedBox(
                      height: deviceHeight*tileScale,
                      child: GestureDetector(
                          onTap: () => Provider.of<AuthProvider>(context).selectRelationType(RelationType.Amicale),
                          child: GradientTile(
                            fontSizeScale: tileFontScale,
                            isBackgroundUnique: Provider.of<AuthProvider>(context).genderPreference.relationType == RelationType.Amicale ? true : false,
                            tileAlignment: Alignment.center,
                            tileText: 'Amicale',
                          )
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: deviceHeight*tileScale,
                      child: GestureDetector(
                          onTap: () => Provider.of<AuthProvider>(context).selectRelationType(RelationType.Serieuse),
                          child: GradientTile(
                            fontSizeScale: tileFontScale,
                            isBackgroundUnique: Provider.of<AuthProvider>(context).genderPreference.relationType == RelationType.Serieuse ? true : false,
                            tileAlignment: Alignment.center,
                            tileText: 'Sérieuse',
                          )
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: deviceHeight*tileScale,
                      child: GestureDetector(
                          onTap: () => Provider.of<AuthProvider>(context).selectRelationType(RelationType.Flirt),
                          child: GradientTile(
                            fontSizeScale: tileFontScale,
                            isBackgroundUnique: Provider.of<AuthProvider>(context).genderPreference.relationType == RelationType.Flirt ? true : false,
                            tileAlignment: Alignment.center,
                            tileText: 'Flirt',
                          )
                      ),
                    ),
                    SizedBox(height: 30),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed(RouteNames.preferences),
                      child: const GradientTile(
                        tileAlignment: Alignment.centerRight,
                        tileText: 'Continuer',
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          CurvedTopBackground(deviceHeight: MediaQuery.of(context).size.height, clipBarSizeScale: topCurvedHeightScale),
        ]
      )
    );
  }
}
