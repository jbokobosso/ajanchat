import 'package:ajanchat/constants/file_assets.dart';
import 'package:ajanchat/constants/globals.dart';
import 'package:ajanchat/providers/auth_provider.dart';
import 'package:ajanchat/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) => Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage(FileAssets.bg2), fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(backgroundImage: NetworkImage(authProvider.loggedUser.images.first as String), radius: MediaQuery.of(context).size.width*0.10),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${authProvider.loggedUser.displayName} \n ${Utils.calculateAge(authProvider.loggedUser.birthDate)} ans", style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05)),
                        SizedBox(
                          height: 20.0,
                          width: MediaQuery.of(context).size.width*0.6,
                          child: ListView(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.horizontal,
                            children: authProvider.loggedUser.preferences.map(
                                    (pref) => Text("$pref ${authProvider.loggedUser.preferences.indexOf(pref) == authProvider.loggedUser.preferences.length-1 ? '' : ' | '}", style: const TextStyle(color: Colors.grey))
                            ).toList(),
                          ),
                        )
                      ],
                    )
                  )
                ],
              ),
            ),
            const Divider(),

            ListTile(
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
            const Divider(),

            ListTile(
                onTap: () {},
                leading: const Icon(Icons.favorite),
                title: const Text("Préférences"),
                subtitle: SizedBox(
                  height: 20.0,
                  width: MediaQuery.of(context).size.width*0.6,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    children: authProvider.loggedUser.preferences.map(
                            (pref) => Text("$pref ${authProvider.loggedUser.preferences.indexOf(pref) == authProvider.loggedUser.preferences.length-1 ? '' : ' | '}", style: const TextStyle(color: Colors.grey))
                    ).toList(),
                  ),
                )
            ),
            const Divider(),

            const ListTile(leading: Icon(Icons.camera_alt_outlined), title: Text("Modifier Mes Photos")),
            const Divider(),

            ListTile(
              leading: const Icon(Icons.baby_changing_station),
              title: const Text("Date d'anniversaire"),
              subtitle: Text(Utils.formatDateToHuman(authProvider.loggedUser.birthDate))
            ),
            const Divider(),
          ],
        ),
      )
    );
  }
}
