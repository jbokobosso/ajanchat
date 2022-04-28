import 'package:ajanchat/constants/file_assets.dart';
import 'package:ajanchat/constants/routes.dart';
import 'package:ajanchat/models/PreferenceModel.dart';
import 'package:ajanchat/providers/auth_provider.dart';
import 'package:ajanchat/widgets/gradient_tile.dart';
import 'package:ajanchat/widgets/loading.dart';
import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class UpdatePreferencesPage extends StatefulWidget {
  const UpdatePreferencesPage({Key? key}) : super(key: key);

  @override
  _UpdatePreferencesPageState createState() => _UpdatePreferencesPageState();
}

class _UpdatePreferencesPageState extends State<UpdatePreferencesPage> {

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
        body: Container(
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage(FileAssets.bg2), fit: BoxFit.cover)),
          child: Consumer<AuthProvider>(
            builder: (context, authProvider, child) => Stack(
              children: [
                Positioned(
                    top: deviceHeight*0.1,
                    left: deviceWidth*0.2,
                    child: Text("Qu'est-ce que tu aimes ?", style: Theme.of(context).textTheme.headline6)
                ),
                PreferenceBubble(index: 0, preference: Provider.of<AuthProvider>(context).preferences[0], height: deviceHeight*0.15, width: deviceHeight*0.15, vertical: 2, horizontal: 0.2),
                PreferenceBubble(index: 1, preference: Provider.of<AuthProvider>(context).preferences[1], height: deviceHeight*0.15, width: deviceHeight*0.15, vertical: 3, horizontal: -0.15),
                PreferenceBubble(index: 2, preference: Provider.of<AuthProvider>(context).preferences[2], height: deviceHeight*0.10, width: deviceHeight*0.15, vertical: 2.9, horizontal: 1.2),
                PreferenceBubble(index: 3, preference: Provider.of<AuthProvider>(context).preferences[3], height: deviceHeight*0.15, width: deviceHeight*0.15, vertical: 2.3, horizontal: 1.7),
                PreferenceBubble(index: 4, preference: Provider.of<AuthProvider>(context).preferences[4], height: deviceHeight*0.15, width: deviceHeight*0.15, vertical: 1.4, horizontal: 2.5),
                PreferenceBubble(index: 5, preference: Provider.of<AuthProvider>(context).preferences[5], height: deviceHeight*0.15, width: deviceHeight*0.15, vertical: 3.2, horizontal: 2.5),
                PreferenceBubble(index: 6, preference: Provider.of<AuthProvider>(context).preferences[6], height: deviceHeight*0.20, width: deviceHeight*0.20, vertical: 2.7, horizontal: 0.75),
                PreferenceBubble(index: 7, preference: Provider.of<AuthProvider>(context).preferences[7], height: deviceHeight*0.15, width: deviceHeight*0.15, vertical: 4.5, horizontal: 0.1),
                PreferenceBubble(index: 8, preference: Provider.of<AuthProvider>(context).preferences[8], height: deviceHeight*0.15, width: deviceHeight*0.15, vertical: 4.5, horizontal: 2.30),
                PreferenceBubble(index: 9, preference: Provider.of<AuthProvider>(context).preferences[9], height: deviceHeight*0.15, width: deviceHeight*0.15, vertical: 5, horizontal: 1.3),
                Positioned(
                    bottom: 20,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => authProvider.onUpdatePreferences(context),
                      child: authProvider.isBusy
                          ? const CircularProgressIndicator()
                          : const GradientTile(
                        tileAlignment: Alignment.centerRight,
                        tileText: "Mettre à jour",
                      ),
                    )
                ),
                authProvider.isBusy ? const Loading() : const SizedBox(height: 0, width: 0)
              ],
            ),
          )
        )
    );
  }
}


class PreferenceBubble extends StatelessWidget {
  final int index;
  final PreferenceModel preference;
  final double width;
  final double height;
  final double vertical;
  final double horizontal;
  
  const PreferenceBubble({
    required this.index, 
    required this.preference, 
    required this.width, 
    required this.height, 
    required this.vertical, 
    required this.horizontal,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Provider.of<AuthProvider>(context, listen: false).selectOrUnselectPreference(index),
      child: AlignPositioned(
        alignment: Alignment.topLeft,
        childWidth: width,
        childHeight: height,
        moveVerticallyByChildWidth: vertical,
        moveHorizontallyByChildHeight: horizontal,
        child: Container(
            child: Center(child: Text(preference.label, style: TextStyle(color: preference.isChosen ? Colors.white : Colors.black),)),
            decoration: BoxDecoration(
                color: preference.isChosen ? Colors.black : const Color.fromRGBO(232, 232, 232, 1),
                shape: BoxShape.circle
            )),
      ),
    );
  }
}

