import 'package:ajanchat/constants/file_assets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 150,
        width: 150,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: const Color(0x99ffffff),
          borderRadius: BorderRadius.circular(16.0)
        ),
        child: Column(
          children: [
            Expanded(child: Lottie.asset(FileAssets.lottieHeartLoading)),
            const Text("Chargement...", style: TextStyle(color: Colors.pinkAccent),)
          ],
        ),
      ),
    );
  }
}
