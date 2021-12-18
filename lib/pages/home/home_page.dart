import 'package:ajanchat/constants/file_assets.dart';
import 'package:ajanchat/providers/auth_provider.dart';
import 'package:ajanchat/providers/home_provider.dart';
import 'package:ajanchat/utils/utils.dart';
import 'package:ajanchat/widgets/ajan_tile.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final iconList = <IconData>[
    Icons.home,
    Icons.message,
    Icons.person,
    Icons.settings,
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: ListTile(
                  leading: GestureDetector(
                    child: Container(
                      width: 30.0,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff51C3FE)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset(FileAssets.crownIcon, color: Colors.white),
                      ),
                    ),
                  ),
                  title: Text("Passer à Premium", style: TextStyle(color: Color(0xff35667E)),),
                  subtitle: Text("Ton crush s'impatiente !", style: TextStyle(color: Color(0xff93B6C6)),),
                  trailing: GestureDetector(
                    child: Container(
                      width: 15.0,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff51C3FE)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset(FileAssets.crossIcon, color: Colors.white),
                      ),
                    ),
                  ),
                  onTap: () => Utils.showToast("En construction..."),
                ),
              ),
              Stack(
                children: Provider.of<HomeProvider>(context).ajanList.map((e) => AjanTile(ajan: e)).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () => null,
                    icon: Image.asset(FileAssets.crossIcon, color: const Color(0xffFFCB58), width: 17),
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite, color: Color(0xffFC77A0)),
                    onPressed: () => null,
                  )
                ],
              )
            ],
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => null,
        backgroundColor: const Color(0xff51C3FE),
        child: Image.asset(FileAssets.thunderIcon, color: Colors.white, width: 15),
      ),
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
}
