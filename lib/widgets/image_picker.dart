import 'dart:io';
import 'package:flutter/material.dart';

class ImageBox extends StatelessWidget {
  final File image;

  const ImageBox(this.image);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1.5),
      width: 60,
      height: 60,
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
      child: Image.file(
        image,
        fit: BoxFit.fill,
      ),
    );
  }
}
