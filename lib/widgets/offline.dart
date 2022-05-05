import 'package:ajanchat/constants/file_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Offline extends StatelessWidget {

  Offline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: SvgPicture.asset(FileAssets.noNetworkIcon, width: MediaQuery.of(context).size.width*0.5));
  }
}
