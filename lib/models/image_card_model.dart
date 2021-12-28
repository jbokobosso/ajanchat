import 'dart:io';

class ImageCardModel {
  File image;
  bool isFilled;

  ImageCardModel({required this.image, this.isFilled = false});
}