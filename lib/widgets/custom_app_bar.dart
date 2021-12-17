import 'package:ajanchat/models/EAppbarType.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'bottom_navigation/TopClipper.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {

  CustomAppBar({Key? key}) : super(key: key);

  final TextStyle popStyle = const TextStyle(color: Colors.black);

  @override
  Widget build(BuildContext context) {

    return AppBar(
      title: const Text('Ajan Chat', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900)),
      flexibleSpace: ClipPath(
        clipper: TopClipper(),
        child: Container(color: Colors.white),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      actions: [
        IconButton(icon: SvgPicture.asset('assets/icons/notification.svg'), onPressed: () => null),
        PopupMenuButton(
          child: SvgPicture.asset('assets/icons/options.svg', width: 33,),
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                child: TextButton(
                  onPressed: () => null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset('assets/icons/invite.svg', width: 20),
                      Text('Inviter des amis ', style: this.popStyle,)
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
  Size get preferredSize => const Size.fromHeight(50.0);
}
