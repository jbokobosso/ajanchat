import 'package:ajanchat/constants/file_assets.dart';
import 'package:ajanchat/constants/globals.dart';
import 'package:ajanchat/constants/routes.dart';
import 'package:ajanchat/providers/auth_provider.dart';
import 'package:ajanchat/widgets/curved_top_background.dart';
import 'package:ajanchat/widgets/gradient_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class InfosPage extends StatefulWidget {
  const InfosPage({Key? key}) : super(key: key);

  @override
  _InfosPageState createState() => _InfosPageState();
}

class _InfosPageState extends State<InfosPage> {

  double topCurvedHeightScale = 0.3;
  double formHeightScale = 0.6;
  double textInputSpacingScale = 0.05;

  String? validator(String? value) {
    return value != null && value.isEmpty ? "" : null;
  }

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
          Consumer<AuthProvider>(
            builder: (context, authProvider, child) => ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Form(
                    key: authProvider.infosFormKey,
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
                                validator: validator,
                                controller: authProvider.lastnameController,
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
                                validator: validator,
                                controller: authProvider.firstnameController,
                              ),
                              SizedBox(height: deviceHeight*textInputSpacingScale),
                              GestureDetector(
                                onTap: () => showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now().subtract(const Duration(days: Globals.minimumAgeInDays)),
                                    firstDate: DateTime.now().subtract(const Duration(days: Globals.minimumAgeInDays)),
                                    lastDate: DateTime.now().subtract(const Duration(days: Globals.maximumAgeInDays))
                                ).then((DateTime? pickedDate) {
                                  authProvider.birthdateController.text = "${pickedDate!.day}-${pickedDate.month}-${pickedDate.year}";
                                  authProvider.birthdateValue = pickedDate;
                                }),
                                child: TextFormField(
                                  enabled: false,
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
                                  validator: validator,
                                  controller: authProvider.birthdateController
                                ),
                              ),
                              SizedBox(height: deviceHeight*textInputSpacingScale),
                              GestureDetector(
                                onTap: authProvider.onLocationTapped,
                                child: TextFormField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                      icon: SvgPicture.asset('assets/icons/location.svg'),
                                      labelText: 'Localisation',
                                      border: const  OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.deepPurple,
                                              width: 5.0,
                                              style: BorderStyle.solid
                                          )
                                      ),
                                      suffixIcon: authProvider.isLocating ? const CircularProgressIndicator() : Container(height: 0, width: 0,)
                                  ),
                                  validator: validator,
                                  controller: authProvider.locationController,
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
                !authProvider.isLocating ? GestureDetector(
                  onTap: () => authProvider.onInfosFormSaved(context),
                  child: const GradientTile(
                    tileAlignment: Alignment.centerRight,
                    tileText: 'Continuer',
                  ),
                ) : Container(height: 0, width: 0)
              ],
            ),
          ),
          CurvedTopBackground(deviceHeight: MediaQuery.of(context).size.height, clipBarSizeScale: topCurvedHeightScale),
        ],
      ),
    );
  }
}
