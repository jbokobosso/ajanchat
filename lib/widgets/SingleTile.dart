import 'package:ajanchat/widgets/TileClipper.dart';
import 'package:flutter/material.dart';

class SingleTile extends StatelessWidget {
  String name;
  int age;
  String picture;

  SingleTile({Key? key,
    required this.name,
    required this.age,
    required this.picture
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ClipPath(
          clipper: TileClipper(),
          child: Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  Expanded(child: Image.asset(picture, fit: BoxFit.fill,)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('$name, $age', style: const TextStyle(fontWeight: FontWeight.bold),),
                  )
                ],
              )
          )
      ),
    );
  }
}