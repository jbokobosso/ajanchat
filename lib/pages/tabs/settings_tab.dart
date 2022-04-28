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
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(image: DecorationImage(image: AssetImage(FileAssets.bg2), fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(FileAssets.appIcon, width: MediaQuery.of(context).size.width*0.2),
          const SizedBox(height: 20.0),
          const Text(Globals.appName),
          const Text("version ${Globals.appVersion}"),
          const SizedBox(height: 20.0),
          const Divider(),
          ListTile(leading: Icon(Icons.security), title: const Text("Politique de confidentialité"), subtitle: Text("Conditions générales d'utilisation", style: TextStyle(color: Theme.of(context).accentColor))),
          const Divider(),
          Consumer<AuthProvider>(
              builder: (context, authProvider, child) => ListTile(
                leading: Icon(Icons.delete, color: Theme.of(context).primaryColor),
                title: const Text("Supprimer Mon Compte", style: TextStyle(color: Colors.red)),
                onTap: () => showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) => AlertDialog(
                        title: const Text("ATTENTION !!!"),
                        content: const Text(Globals.deleteAccountWarningMessage),
                        actions: [
                          TextButton(onPressed: () => authProvider.deleteAccountAndLogout(context), child: Text("Confirmer Suppression", style: TextStyle(color: Theme.of(context).primaryColor),)),
                          TextButton(onPressed: () => Navigator.pop(context), child: Text("Ne plus supprimer", style: TextStyle(color: Theme.of(context).accentColor),))
                        ]
                    )
                ),
                trailing: authProvider.isLoggingOut ? const CircularProgressIndicator() : const SizedBox(height: 0, width: 0),
              )),
          const Divider(),
          Consumer<AuthProvider>(
            builder: (context, authProvider, child) => ListTile(
              leading: Icon(Icons.logout, color: Theme.of(context).primaryColor),
              title: const Text("Déconnexion"),
              onTap: () => showDialog(
                barrierDismissible: false,
                context: context,
                builder: (_) => AlertDialog(
                  content: const Text("Etes-vous sûr ?"),
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
      ),
    );
  }
}
