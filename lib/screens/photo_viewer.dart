import 'package:flutter/material.dart';

import 'package:photo_view/photo_view.dart';

class PhotoViewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final Map args = ModalRoute.of(context).settings.arguments;

    final String title = args['title'];
    final String image = args['image'];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: Text(title),
      ),
      backgroundColor: Colors.black,
      body: PhotoView(
        imageProvider: NetworkImage(image),
      ),
    );
  }
}
