import 'dart:io';

class ImageCardModel {
  File image;
  bool isFilled;
  String networkImage;

  ImageCardModel({required this.image, this.isFilled = false, this.networkImage = ""});
}