import 'dart:io';

import 'package:ajanchat/constants/file_assets.dart';
import 'package:ajanchat/constants/globals.dart';
import 'package:ajanchat/constants/routes.dart';
import 'package:ajanchat/models/image_card_model.dart';
import 'package:ajanchat/providers/auth_provider.dart';
import 'package:ajanchat/widgets/gradient_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class PicturesPage extends StatefulWidget {
  const PicturesPage({Key? key}) : super(key: key);

  @override
  _PicturesPageState createState() => _PicturesPageState();
}

class _PicturesPageState extends State<PicturesPage> {

  double topCurvedHeightScale = 0.2;
  double formHeightScale = 0.6;
  double textInputSpacingScale = 0.05;

  final double tileScale = 0.04;
  final double tileFontScale = 0.03;

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
            padding: EdgeInsets.only(
              bottom: 20.0,
              top: deviceHeight * 0.07,
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(FileAssets.bg2),
                    fit: BoxFit.cover)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Dernière étape', style: Theme.of(context).textTheme.headline6),
                const SizedBox(height: 20.0),
                const Text('Ajoutes au moins trois (0${Globals.maximumProfilePicturesCount}) photos'),
                Consumer<AuthProvider>(
                  builder: (context, authProvider, child) => authProvider.images.takeWhile((value) => value.isFilled).toList().length < Globals.maximumProfilePicturesCount
                      ? Column(
                    children: [
                      const SizedBox(height: 20.0),
                      const Text("Ne laisses pas d'espaces au milieu. Remplis les cases de façon consécutive", style: TextStyle(color: Colors.red), textAlign: TextAlign.center),
                    ],
                  )
                      : const SizedBox(height: 0, width: 0),
                ),
                SizedBox(
                  height: deviceHeight * 0.6,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      children: [
                        ImageCard(0, Provider.of<AuthProvider>(context).images[0].image),
                        ImageCard(1, Provider.of<AuthProvider>(context).images[1].image),
                        ImageCard(2, Provider.of<AuthProvider>(context).images[2].image),
                        ImageCard(3, Provider.of<AuthProvider>(context).images[3].image),
                        ImageCard(4, Provider.of<AuthProvider>(context).images[4].image),
                        ImageCard(5, Provider.of<AuthProvider>(context).images[5].image),
                      ],
                    ),
                  ),
                ),
                Consumer<AuthProvider>(
                  builder: (context, authProvider, child) => Column(
                    children: [
                      authProvider.isUploading || authProvider.isBusy
                          ? LottieBuilder.asset(FileAssets.lottieUploading, width: MediaQuery.of(context).size.width*0.3)
                          : authProvider.images.takeWhile((value) => value.isFilled).toList().length >= Globals.maximumProfilePicturesCount
                            ? GestureDetector(
                              onTap: () => Provider.of<AuthProvider>(context, listen: false).onPicturesFormSaved(context),
                              child: const GradientTile(
                                  tileText: "S'inscrire",
                                  tileAlignment: Alignment.centerRight),
                            )
                            : const SizedBox(height: 0, width: 0),
                      authProvider.isUploading
                          ? Column(
                              children: [
                                const Text("Téléversement des images"),
                                Text("Image N° ${authProvider.currentUploadingImageCount}", style: TextStyle(color: Theme.of(context).primaryColor),),
                                Text("${authProvider.uploadPercentage.ceil()} %")
                              ],
                            )
                          : Container()
                    ],
                  )
                )
              ],
            )));
  }
}

class ImageCard extends StatelessWidget {
  int index;
  File image = File("");
  ImageCard(this.index, this.image, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) => GestureDetector(
        onTap: () => authProvider.pickImage(index, context),
        child: Stack(
          alignment: Alignment.center,
          children: [
            image.path == ""
                ? Container(color: const Color(0xD1D1D1D1))
                : Image.file(image, fit: BoxFit.cover, width: double.infinity, height: double.infinity),
            image.path == ""
                ? const Icon(Icons.add_circle_outline, color: Color(0x90909090))
                : Container(),
            Positioned(
                child: image.path != ""
                    ? GestureDetector(
                      onTap: () => authProvider.clearPictures(index),
                      child: Container(
                          child: IconButton(icon: SvgPicture.asset(FileAssets.closeIcon), onPressed: () => authProvider.clearPictures(index)),
                          decoration: const BoxDecoration(color: Color(0x80ffffff)),
                        ),
                    )
                    : Container()
            )
          ],
        ),
      ),
    );
  }
}

