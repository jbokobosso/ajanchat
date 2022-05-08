import 'package:ajanchat/constants/file_assets.dart';
import 'package:ajanchat/constants/globals.dart';
import 'package:ajanchat/pages/tabs/chat/chat_tab.dart';
import 'package:ajanchat/pages/tabs/home_tab.dart';
import 'package:ajanchat/pages/tabs/profile_tab.dart';
import 'package:ajanchat/pages/tabs/request/request_tab.dart';
import 'package:ajanchat/pages/tabs/settings_tab.dart';
import 'package:ajanchat/providers/auth_provider.dart';
import 'package:ajanchat/providers/chat_provider.dart';
import 'package:ajanchat/widgets/custom_app_bar.dart';
import 'package:ajanchat/widgets/otp.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {

  final navigationTabs = const <Widget>[
    HomeTab(),
    RequestTab(),
    ChatTab(),
    ProfileTab(),
    SettingsTab()
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(

      ),
      body: Consumer<AuthProvider>(builder: (context, authProvider, child) => navigationTabs[authProvider.currentTabIndex]),
      bottomNavigationBar: Consumer<AuthProvider>(
        builder: (context, authProvider, child) => BottomNavigationBar(
          currentIndex: authProvider.currentTabIndex,
          onTap: (index) => setState(() => authProvider.changeTabIndex(index)),
          selectedItemColor: Colors.pinkAccent,
          unselectedItemColor: Colors.white,
          items: [
            const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil", backgroundColor: Color(0xff19516F)),
            BottomNavigationBarItem(
              icon: Badge(
                badgeColor: Colors.blue,
                badgeContent: Text(Provider.of<ChatProvider>(context).chats.length.toString(), style: const TextStyle(color: Colors.white)),
                child: const Icon(Icons.volunteer_activism),
              ),
              label: "Requetes"
            ),
            const BottomNavigationBarItem(icon: Icon(Icons.message), label: "Discussions", backgroundColor: Color(0xff19516F)),
            const BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil", backgroundColor: Color(0xff19516F)),
            const BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Paramètres", backgroundColor: Color(0xff19516F)),
          ],
        )
      )
    );
  }

  @override
  Future<void> didChangeDependencies() async {
    if(Provider.of<AuthProvider>(context).loggedUser.displayName == null || Provider.of<AuthProvider>(context).loggedUser.displayName!.isEmpty) {
      await Provider.of<AuthProvider>(context, listen: false).loadLoggedUserFromFirebaseAndNotify();
    }
    Provider.of<ChatProvider>(context, listen: false).loadChats();
    super.didChangeDependencies();
  }
}
