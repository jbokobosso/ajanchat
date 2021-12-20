import 'dart:async';

import 'package:ajanchat/constants/file_assets.dart';
import 'package:ajanchat/constants/globals.dart';
import 'package:ajanchat/constants/routes.dart';
import 'package:ajanchat/providers/auth_provider.dart';
import 'package:ajanchat/utils/utils.dart';
import 'package:ajanchat/widgets/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class Otp extends StatefulWidget {

  Otp();

  @override
  _OtpState createState() =>
      _OtpState();
}

class _OtpState extends State<Otp> {
  bool isBusy = false;
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    dynamic params = ModalRoute.of(context)?.settings.arguments;
    String phone = params['phoneNumber'];
    String code = params['code'];

    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.only(top: 30.0),
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage(FileAssets.bg2), fit: BoxFit.cover)),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 6,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(FileAssets.appIcon),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Vérification Numéro De Téléphone',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                    child: RichText(
                      text: TextSpan(
                          text: "Entrez le code envoyé au ",
                          children: [
                            TextSpan(
                                text: phone,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                          ],
                          style: const TextStyle(color: Colors.black54, fontSize: 15)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Form(
                    key: formKey,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 30),
                        child: PinCodeTextField(
                          appContext: context,
                          pastedTextStyle: TextStyle(
                            color: Colors.green.shade600,
                            fontWeight: FontWeight.bold,
                          ),
                          length: 6,
                          obscureText: true,
                          obscuringCharacter: '*',
                          obscuringWidget: Icon(Icons.favorite, color: Theme.of(context).primaryColor,),
                          blinkWhenObscuring: true,
                          animationType: AnimationType.fade,
                          validator: (v) {
                            if (v!.length < 3) {
                              return "Veuillez tout remplir";
                            } else {
                              return null;
                            }
                          },
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            activeFillColor: Colors.white,
                          ),
                          cursorColor: Colors.black,
                          animationDuration: const Duration(milliseconds: 300),
                          enableActiveFill: true,
                          errorAnimationController: errorController,
                          controller: textEditingController,
                          keyboardType: TextInputType.number,
                          boxShadows: const [
                            BoxShadow(
                              offset: Offset(0, 1),
                              color: Colors.black12,
                              blurRadius: 10,
                            )
                          ],
                          onCompleted: (v) {
                            if (kDebugMode) {
                              print("Completed");
                            }
                          },
                          // onTap: () {
                          //   print("Pressed");
                          // },
                          onChanged: (value) {
                            print(value);
                            setState(() {
                              currentText = value;
                            });
                          },
                          beforeTextPaste: (text) {
                            if (kDebugMode) {
                              print("Permettre de coller $text");
                            }
                            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                            //but you can show anything you want here, like your pop up saying wrong paste format or etc
                            return true;
                          },
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Consumer<AuthProvider>(
                      builder: (context, authProvider, child) => Text(
                        authProvider.otpErrorMessage != "" ? authProvider.otpErrorMessage : "",
                        style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      )
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Je n'ai pas reçu le code? ",
                        style: TextStyle(color: Colors.black54, fontSize: 15),
                      ),
                      TextButton(
                          onPressed: () async {
                            await Provider.of<AuthProvider>(context, listen: false).authenticateByFirebase(phone);
                            Utils.showToast("Code renvoyé !");
                          },
                          child: const Text(
                            "RENVOYER",
                            style: TextStyle(
                                color: Color(0xFF91D3B3),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ))
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                          color: Colors.green.shade300,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.green.shade200,
                                offset: const Offset(1, -2),
                                blurRadius: 5),
                            BoxShadow(
                                color: Colors.green.shade200,
                                offset: const Offset(-1, 2),
                                blurRadius: 5)
                          ]),
                    margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
                    child: ButtonTheme(
                      height: 50,
                      child: TextButton(
                        onPressed: () async {
                          formKey.currentState!.validate();
                          // conditions for validating
                          if (currentText.length != 6 || await Provider.of<AuthProvider>(context, listen: false).verifyCodeSentManually(code, currentText) == false) {
                            errorController!.add(ErrorAnimationType.shake); // Triggering error shake animation
                            setState(() => hasError = true);
                          } else {
                            setState((){
                              hasError = false;
                              Navigator.of(context).pushNamed(RouteNames.infos);
                              Utils.showToast("Code vérifié!!");
                            });
                          }
                        },
                        child: Center(child: Text("Vérifier".toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),)),)
                    )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                          child: TextButton(
                            child: const Text("Effacer"),
                            onPressed: () {
                              textEditingController.clear();
                            },
                          )),
                      kDebugMode ? Flexible(
                          child: TextButton(
                            child: const Text("Affecter Valeur Dev"),
                            onPressed: () {
                              setState(() {
                                textEditingController.text = Globals.firebaseDevSmsCode;
                              });
                            },
                          )) : Container(),
                    ],
                  )
                ],
              ),
            ),
          ),
          isBusy ? const Loading() : Container()
        ],
      ),
    );
  }
}