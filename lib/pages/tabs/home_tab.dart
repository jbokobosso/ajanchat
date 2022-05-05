import 'dart:async';

import 'package:ajanchat/constants/file_assets.dart';
import 'package:ajanchat/widgets/offline.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ajanchat/providers/auth_provider.dart';
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
  bool isBusy = true;
  AuthProvider authProvider = AuthProvider();
  late StreamSubscription<ConnectivityResult> subscription;
  late ConnectivityResult connectivityStatus;

  @override
  initState() {
    super.initState();
    connectivityStatus = ConnectivityResult.none;
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        connectivityStatus = result;
      });
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    authProvider = Provider.of<AuthProvider>(context);
    await Provider.of<HomeProvider>(context, listen: false).getAjanList();
  }

  @override
  dispose() {
    super.dispose();

    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder:(context, homeProvider, child) => Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage(FileAssets.bg2), fit: BoxFit.cover)),
          child: homeProvider.isBusy
              ? const Loading()
              : connectivityStatus == ConnectivityResult.none
                ? Offline()
                : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                    homeProvider.ajanList.isNotEmpty ? Stack(
                      children: homeProvider.ajanList.map((e) => AjanTile(ajan: e)).toList(),
                    ) : const Text("Vide pour le moment...\nVeuillez revenir plus tard."),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     IconButton(
                    //       onPressed: () => null,
                    //       icon: Image.asset(FileAssets.crossIcon, color: const Color(0xffFFCB58), width: 17),
                    //     ),
                    //     IconButton(
                    //       icon: const Icon(Icons.favorite, color: Color(0xffFC77A0)),
                    //       onPressed: () => null,
                    //     )
                    //   ],
                    // )
                  ],
          )
      )
    );
  }
}
