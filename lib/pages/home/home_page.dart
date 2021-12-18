import 'package:ajanchat/constants/file_assets.dart';
import 'package:ajanchat/constants/routes.dart';
import 'package:ajanchat/providers/auth_provider.dart';
import 'package:ajanchat/widgets/ajan_tile.dart';
import 'package:ajanchat/widgets/gradient_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: SvgPicture.asset(FileAssets.backArrowIcon),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage(FileAssets.bg2), fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () => null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListTile(
                  leading: IconButton(
                    onPressed: () => null,
                    icon: CircleAvatar(
                      child: Image.asset(FileAssets.crownIcon, color: Colors.white,),
                      backgroundColor: Color(0xff51C3FE),
                    ),
                  ),
                  title: Text("Passer à Premium", style: TextStyle(color: Color(0xff35667E)),),
                  subtitle: Text("Ton crush s'impatiente !", style: TextStyle(color: Color(0xff93B6C6)),),
                  trailing: IconButton(
                    onPressed: () => null,
                    icon: CircleAvatar(
                      child: IconButton(
                        onPressed: () => null,
                        icon: Image.asset(FileAssets.crossIcon, color: Colors.white),
                      ),
                      backgroundColor: Color(0xff51C3FE),
                    ),
                  ),
                  onTap: () => null,
                ),
              ),
              AjanTile(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => null,
                    icon: Image.asset(FileAssets.crossIcon, color: Color(0xffFFCB58),),
                  ),
                  IconButton(
                    iconSize: 100,
                    onPressed: () => null,
                    icon: CircleAvatar(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(FileAssets.thunderIcon, color: Colors.white),
                      ),
                      backgroundColor: Color(0xff51C3FE),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.favorite, color: Color(0xffFC77A0)),
                    onPressed: () => null,
                  )
                ],
              )
            ],
          ),
        )
      ),
      bottomNavigationBar: Consumer<AuthProvider>(
        builder: (context, authProvider, child) => BottomNavigationBar(
          onTap: (index) => authProvider.changeTabIndex(index),
          currentIndex: authProvider.currentTabIndex,
          type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              activeIcon: Icon(Icons.home),
              label: '___',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(FileAssets.chatIcon),
              activeIcon: SvgPicture.asset(FileAssets.chatIcon),
              label: 'Chat', backgroundColor: Color(0xff19516F)
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(FileAssets.profileIcon),
              activeIcon: SvgPicture.asset(FileAssets.profileIcon),
              label: 'Profil', backgroundColor: Color(0xff19516F)
            ),
          ],
        ),
      ),
    );
  }
}
