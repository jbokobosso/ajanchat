import 'package:ajanchat/constants/file_assets.dart';
import 'package:ajanchat/providers/home_provider.dart';
import 'package:ajanchat/utils/utils.dart';
import 'package:ajanchat/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ajanchat/widgets/ajan_tile.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  bool isBusy = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage(FileAssets.bg2), fit: BoxFit.cover)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
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
                      title: const Text("Passer à Premium", style: TextStyle(color: Color(0xff35667E)),),
                      subtitle: const Text("Ton crush s'impatiente !", style: TextStyle(color: Color(0xff93B6C6)),),
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
            ),
            isBusy ? const Loading() : Container()
          ],
        )
    );
  }
}
