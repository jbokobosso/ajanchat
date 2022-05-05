import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'bottom_navigation/TopClipper.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {

  CustomAppBar({Key? key}) : super(key: key);

  final TextStyle popStyle = const TextStyle(color: Colors.black);

  @override
  Widget build(BuildContext context) {

    return AppBar(
      centerTitle: true,
      title: const Text('Ajan Chat', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
      flexibleSpace: ClipPath(
        clipper: TopClipper(),
        child: Container(color: Theme.of(context).accentColor),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      actions: [
        PopupMenuButton(
          child: SvgPicture.asset('assets/icons/options.svg', width: 33, color: Colors.white),
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                child: TextButton(
                  onPressed: () {  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset('assets/icons/invite.svg', width: 20),
                      Text('Inviter des amis ', style: popStyle,)
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                child: TextButton(
                  onPressed: () => null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset('assets/icons/shield.svg', width: 20,),
                      Text('Ajan Chat FAQ', style: this.popStyle,)
                    ],
                  ),
                ),
              ),
            ];
          },
          onCanceled: () => print('hey'),
          onSelected: (event) => print('Spartanovich_117'),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100.0);
}
