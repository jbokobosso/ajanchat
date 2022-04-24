import 'package:ajanchat/constants/file_assets.dart';
import 'package:ajanchat/constants/globals.dart';
import 'package:ajanchat/providers/auth_provider.dart';
import 'package:ajanchat/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({Key? key}) : super(key: key);

  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(FileAssets.appIcon, width: 200,),
        const Text(Globals.appName),
        const Text("version ${Globals.appVersion}"),
        const Divider(),
        ListTile(leading: Icon(Icons.security), title: const Text("Politique de confidentialité"), subtitle: Text("Conditions générales d'utilisation", style: TextStyle(color: Theme.of(context).accentColor),),),
        const Divider(),
        Consumer<AuthProvider>(
          builder: (context, authProvider, child) => ListTile(
            onTap: () {
              if(authProvider.loggedUser.displayName == null) {
                authProvider.loadLoggedUserFromFirebaseAndNotify();
                authProvider.notifyListeners();
              } else {
                Utils.showToast("Merci, profil déjà chargé...");
              }
            },
            leading: const Icon(Icons.account_circle),
            title: const Text("Profil"),
            subtitle: Text(
              authProvider.loggedUser.displayName ?? "Tapez pour charger votre profil",
              style: TextStyle(color: authProvider.loggedUser.displayName == null ? Theme.of(context).primaryColor : Colors.grey),
            )
          ),
        ),
        const Divider(),
        const ListTile(leading: Icon(Icons.share), title: Text("Partager")),
        const Divider(),
        const ListTile(leading: Icon(Icons.comment), title: Text("Notez sur PlayStore")),
        const Divider(),
        Consumer<AuthProvider>(
          builder: (context, authProvider, child) => ListTile(
            leading: Icon(Icons.logout, color: Theme.of(context).primaryColor),
            title: const Text("Déconnexion"),
            onTap: () => showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) => AlertDialog(
                content: Text("Etes-vous sûr ?"),
                actions: [
                  TextButton(onPressed: () => authProvider.logout(context), child: Text("Oui", style: TextStyle(color: Theme.of(context).primaryColor),)),
                  TextButton(onPressed: () => Navigator.pop(context), child: Text("Non", style: TextStyle(color: Theme.of(context).accentColor),))
                ]
              )
            ),
            trailing: authProvider.isLoggingOut ? const CircularProgressIndicator() : const SizedBox(height: 0, width: 0),
        )),
        const Divider()
      ],
    );
  }
}
