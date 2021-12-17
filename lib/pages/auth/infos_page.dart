import 'package:ajanchat/constants/file_assets.dart';
import 'package:ajanchat/constants/routes.dart';
import 'package:ajanchat/widgets/curved_top_background.dart';
import 'package:ajanchat/widgets/gradient_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InfosPage extends StatefulWidget {
  const InfosPage({Key? key}) : super(key: key);

  @override
  _InfosPageState createState() => _InfosPageState();
}

class _InfosPageState extends State<InfosPage> {

  double topCurvedHeightScale = 0.3;
  double formHeightScale = 0.6;
  double textInputSpacingScale = 0.05;

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
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Form(
                  child: Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*(topCurvedHeightScale/2)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: SizedBox(
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
                            SizedBox(height: deviceHeight*textInputSpacingScale),
                            TextFormField(
                              decoration: InputDecoration(
                                  icon: SvgPicture.asset('assets/icons/profile.svg'),
                                  labelText: 'Prénom',
                                  border: const  OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.deepPurple,
                                          width: 5.0,
                                          style: BorderStyle.solid
                                      )
                                  )
                              ),
                            ),
                            SizedBox(height: deviceHeight*textInputSpacingScale),
                            TextFormField(
                              decoration: InputDecoration(
                                  icon: SvgPicture.asset('assets/icons/calendar.svg'),
                                  labelText: 'Date de naissance',
                                  border: const  OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.deepPurple,
                                          width: 5.0,
                                          style: BorderStyle.solid
                                      )
                                  )
                              ),
                            ),
                            SizedBox(height: deviceHeight*textInputSpacingScale),
                            TextFormField(
                              decoration: InputDecoration(
                                  icon: SvgPicture.asset('assets/icons/location.svg'),
                                  labelText: 'Localisation',
                                  border: const  OutlineInputBorder(
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
          ),
          CurvedTopBackground(deviceHeight: MediaQuery.of(context).size.height, clipBarSizeScale: topCurvedHeightScale),
        ],
      ),
    );
  }
}
