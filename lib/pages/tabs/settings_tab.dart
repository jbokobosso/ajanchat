import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({Key? key}) : super(key: key);

  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Settings Page', style: TextStyle(color: Theme.of(context).accentColor, fontSize: 20.0)),
              Lottie.asset("assets/lottie/construction.json", fit: BoxFit.contain),
              const Text('Cette page est en construction...')
            ],
          )
      ),
    );
  }
}
