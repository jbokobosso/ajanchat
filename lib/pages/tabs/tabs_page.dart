import 'package:ajanchat/constants/file_assets.dart';
import 'package:ajanchat/pages/tabs/chat/chat_tab.dart';
import 'package:ajanchat/pages/tabs/home_tab.dart';
import 'package:ajanchat/pages/tabs/profile_tab.dart';
import 'package:ajanchat/pages/tabs/settings_tab.dart';
import 'package:ajanchat/providers/auth_provider.dart';
import 'package:ajanchat/widgets/otp.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {

  final iconList = <IconData>[
    Icons.home,
    Icons.message,
    Icons.person,
    Icons.settings,
  ];

  final navigationTabs = const <Widget>[
    HomeTab(),
    ChatTab(),
    ProfileTab(),
    SettingsTab()
  ];

  @override
  Widget build(BuildContext context) {

    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        // leading: IconButton(
        //   icon: SvgPicture.asset(FileAssets.backArrowIcon),
        //   onPressed: () => Navigator.of(context).pop(),
        // ),
      ),
      body: Consumer<AuthProvider>(builder: (context, authProvider, child) => navigationTabs[authProvider.currentTabIndex]),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => null,
      //   backgroundColor: const Color(0xff51C3FE),
      //   child: Image.asset(FileAssets.thunderIcon, color: Colors.white, width: 15),
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Consumer<AuthProvider>(
        builder: (context, authProvider, child) => AnimatedBottomNavigationBar(
          inactiveColor: Colors.white,
          activeColor: Colors.pinkAccent,
          backgroundColor: const Color(0xff19516F),
          icons: iconList,
          activeIndex: authProvider.currentTabIndex,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.verySmoothEdge,
          leftCornerRadius: 32,
          rightCornerRadius: 32,
          onTap: (index) => setState(() => authProvider.changeTabIndex(index)),
          //other params
        ),
      )
    );
  }

  @override
  Future<void> didChangeDependencies() async {
    if(Provider.of<AuthProvider>(context).loggedUser.displayName == null || Provider.of<AuthProvider>(context).loggedUser.displayName!.isEmpty) {
      await Provider.of<AuthProvider>(context, listen: false).loadLoggedUserFromFirebaseAndNotify();
    }
    super.didChangeDependencies();
  }
}
