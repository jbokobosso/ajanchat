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

  GlobalKey<FormState> displayNameFormKey = GlobalKey<FormState>();
  String firstnameInput = "";
  String lastnameInput = "";


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

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
            ),    //Profile banner
            const Divider(),

            ListTile(
                onTap: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (buildContext) => AlertDialog(
                        content: SizedBox(
                          height: MediaQuery.of(buildContext).size.height*0.4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text("Modifier Profil", style: TextStyle(fontSize: 20)),
                              SizedBox(
                                width: MediaQuery.of(context).size.width*0.7,
                                child: Form(
                                  key: displayNameFormKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        initialValue: authProvider.loggedUser.displayName!.split(" ").first,
                                        onSaved: (value) => firstnameInput = value!.trim(),
                                        decoration: const InputDecoration(
                                            label: Text("Prénom"),
                                            suffixIcon: Icon(Icons.account_circle),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.deepPurple,
                                                    width: 5.0,
                                                    style: BorderStyle.solid
                                                )
                                            )
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      TextFormField(
                                        initialValue: authProvider.loggedUser.displayName!.split(" ")[1],
                                        onSaved: (value) => lastnameInput = value!.trim(),
                                        decoration: const InputDecoration(
                                            label: Text("Nom"),
                                            suffixIcon: Icon(Icons.account_circle),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.deepPurple,
                                                    width: 5.0,
                                                    style: BorderStyle.solid
                                                )
                                            )
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        actions: authProvider.isBusy
                            ? [const CircularProgressIndicator()]
                            : [
                                TextButton(
                                  onPressed: Navigator.of(context).pop,
                                  child: const Text("Annuler"),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    displayNameFormKey.currentState!.save();
                                    bool result = await authProvider.updateProfileName("$firstnameInput ${lastnameInput.toUpperCase()}");
                                    if(result) Navigator.pop(context);
                                  },
                                  child: const Text("Modifier"),
                                )
                              ],
                      )
                  );
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
