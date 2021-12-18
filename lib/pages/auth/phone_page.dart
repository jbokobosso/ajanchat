import 'package:ajanchat/constants/file_assets.dart';
import 'package:ajanchat/constants/routes.dart';
import 'package:ajanchat/widgets/curved_top_background.dart';
import 'package:ajanchat/widgets/custom_app_bar.dart';
import 'package:ajanchat/widgets/gradient_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PhonePage extends StatefulWidget {
  const PhonePage({Key? key}) : super(key: key);

  @override
  _PhonePageState createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {

  double formHeightScale = 0.2;
  double topCurvedHeightScale = 0.4;
  double textInputSpacingScale = 0.2;

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
        children: [
          CurvedTopBackground(deviceHeight: MediaQuery.of(context).size.height, clipBarSizeScale: topCurvedHeightScale),
          ListView(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*topCurvedHeightScale),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Form(
                    child: TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            icon: SvgPicture.asset(FileAssets.callIcon),
                            labelText: 'Numéro de téléphone',
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.deepPurple,
                                    width: 5.0,
                                    style: BorderStyle.solid
                                )
                            )
                        )
                    )
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*textInputSpacingScale),
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(RouteNames.otp),
                child: const GradientTile(
                  tileAlignment: Alignment.centerRight,
                  tileText: 'Continuer',
                ),
              )

            ],
          )
        ],
      ),
    );
  }
}
