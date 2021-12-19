import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Profile Page', style: TextStyle(color: Theme.of(context).accentColor, fontSize: 20.0)),
              Lottie.asset("assets/lottie/construction.json", fit: BoxFit.contain),
              const Text('Cette page est en construction...')
            ],
          )
      ),
    );
  }
}
