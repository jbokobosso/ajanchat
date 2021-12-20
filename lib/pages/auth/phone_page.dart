import 'package:ajanchat/constants/file_assets.dart';
import 'package:ajanchat/constants/routes.dart';
import 'package:ajanchat/providers/auth_provider.dart';
import 'package:ajanchat/widgets/curved_top_background.dart';
import 'package:ajanchat/widgets/custom_app_bar.dart';
import 'package:ajanchat/widgets/gradient_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

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
          Consumer<AuthProvider>(
            builder: (context, authProvider, child) => ListView(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*topCurvedHeightScale),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Form(
                      key: authProvider.registerFormKey,
                      child: Column(
                        children: [
                          InternationalPhoneNumberInput(
                            onInputChanged: (PhoneNumber number) {
                              print(number.phoneNumber);
                            },
                            selectorConfig: const SelectorConfig(
                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                            ),
                            ignoreBlank: true,
                            autoValidateMode: AutovalidateMode.disabled,
                            selectorTextStyle: const TextStyle(color: Colors.black),
                            textFieldController: authProvider.phoneController,
                            formatInput: true,
                            keyboardType: TextInputType.phone,
                            inputBorder: const OutlineInputBorder(),
                            countries: const ['TG', 'BF', 'BJ', 'GH'],

                          )
                        ],
                      )
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*textInputSpacingScale),
                GestureDetector(
                  onTap: () => authProvider.onRegisterFormSaved(context),
                  child: const GradientTile(
                    tileAlignment: Alignment.centerRight,
                    tileText: 'Continuer',
                  ),
                )
              ],
            )
          )
        ],
      ),
    );
  }
}
