import 'package:ajanchat/constants/file_assets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class InfoAlert extends StatelessWidget {
  final String title;
  final String message;
  final String lottieAsset;
  final String imageAsset;
  const InfoAlert(this.message, {this.lottieAsset="", this.imageAsset="", this.title="Info", Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, textAlign: TextAlign.center),
      content: SizedBox(
        height: MediaQuery.of(context).size.height*0.5,
        child: Column(
          children: [
            lottieAsset != "" ? Lottie.asset(lottieAsset) : Image.asset(imageAsset),
            Text(message, textAlign: TextAlign.center,)
          ],
        ),
      ),
    );
  }
}
