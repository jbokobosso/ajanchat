import 'package:ajanchat/constants/file_assets.dart';
import 'package:ajanchat/constants/routes.dart';
import 'package:ajanchat/providers/auth_provider.dart';
import 'package:ajanchat/utils/utils.dart';
import 'package:ajanchat/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartupPage extends StatefulWidget {
  const StartupPage({Key? key}) : super(key: key);

  @override
  _StartupPageState createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    startupLogic();
    super.didChangeDependencies();
  }

  Future<void> startupLogic() async {
    bool userIsLogged = await Provider.of<AuthProvider>(context, listen: false).checkUserIsLogged();
    if(userIsLogged) {
      await Provider.of<AuthProvider>(context, listen: false).loadLoggedUserFromFirebaseAndNotify();
      Navigator.of(context).pushNamedAndRemoveUntil(RouteNames.tabs, (Route route) => false);
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(RouteNames.auth, (Route route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(FileAssets.bgImage),
                  fit: BoxFit.cover
              )
          ),
          child: const Loading(),
        )
    );
  }
}

