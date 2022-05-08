import 'package:ajanchat/constants/file_assets.dart';
import 'package:ajanchat/pages/tabs/request/request_tile.dart';
import 'package:ajanchat/providers/request_provider.dart';
import 'package:ajanchat/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class RequestTab extends StatefulWidget {
  const RequestTab({Key? key}) : super(key: key);

  @override
  _RequestTabState createState() => _RequestTabState();
}

class _RequestTabState extends State<RequestTab> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RequestProvider>(
        builder: (context, requestProvider, child) => Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage(FileAssets.bg2), fit: BoxFit.cover)),
          child: Stack(
            children: [
              requestProvider.requests.isNotEmpty
                  ? GridView.builder(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 120.0),
                itemCount: requestProvider.requests.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisExtent: 300,
                    maxCrossAxisExtent: MediaQuery.of(context).size.width/2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0
                ),
                itemBuilder: (BuildContext context, index) => RequestTile(ajanModel: requestProvider.requests[index]),
              )
                  : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(FileAssets.lottieEmptyBox),
                      Text("Oupsss... Revenez plus tard", style: TextStyle(color: Theme.of(context).primaryColor))
                    ],
                  ),
              requestProvider.isBusy
                  ? const Loading()
                  : Container()
            ],
          ),
        )
    );
  }
}
