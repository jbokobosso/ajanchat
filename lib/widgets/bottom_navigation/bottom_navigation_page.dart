import 'package:ajanchat/pages/chat/chat_page.dart';
import 'package:ajanchat/pages/home/home_page.dart';
import 'package:ajanchat/pages/profile/profile_page.dart';
import 'package:ajanchat/providers/bottom_navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key? key}) : super(key: key);

  @override
  _BottomNavigationPageState createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  @override
  Widget build(BuildContext context) {
    
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    List<Widget> navigationList = const [
      HomePage(),
      ChatPage(),
      ProfilePage(),
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: navigationList[Provider.of<BottomNavigationProvider>(context).currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5.0,
        onTap: (newIndex) => Provider.of<BottomNavigationProvider>(context).changeTabIndex(newIndex),
        currentIndex: Provider.of<BottomNavigationProvider>(context).currentTabIndex,
        selectedItemColor: const Color(0xff6A36FF),
        type: BottomNavigationBarType.shifting,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Color(0xff6A36FF)),
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/home.svg', width: deviceWidth*0.05),
              label: '___',
              activeIcon: SvgPicture.asset('assets/icons/home.svg', width: deviceWidth*0.05, color: Color(0xff6A36FF))
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/chat.svg', width: deviceWidth*0.05),
              label: '___',
              activeIcon: SvgPicture.asset('assets/icons/chat.svg', width: deviceWidth*0.05, color: Color(0xff6A36FF))
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/profile.svg'),
              label: '___',
              activeIcon: SvgPicture.asset('assets/icons/profile.svg', width: deviceWidth*0.05, color: Color(0xff6A36FF))
          ),
        ],
      ),
    );
  }
}

