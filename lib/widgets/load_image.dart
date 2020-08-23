import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:photo_view/photo_view.dart';

class FireStorageService extends ChangeNotifier {
  FireStorageService();

  static Future<dynamic> loadFromStorage(
      BuildContext context, String image) async {
    return await FirebaseStorage.instance.ref().child(image).getDownloadURL();
  }
}

class LoadImage extends StatelessWidget {
  final String image;

  const LoadImage(this.image);

  @override
  Widget build(BuildContext context) {
    Future<String> _getImage(BuildContext context, String image) async {
      Image m;
      String downloadUrl =
          await FireStorageService.loadFromStorage(context, image) as String;
      return downloadUrl;
    }

    return FutureBuilder(
        future: _getImage(context, image),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done)
            return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'photoViewer',
                      arguments: {'image': snapshot.data, 'title': ''});
                },
                child: Image.network(
                  snapshot.data,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) => progress == null ? child : Center(
                      child: Image.asset(
                    'images/loading.png',
                    fit: BoxFit.fill,
                    height: 80,
                    width: 80,
                  )),
                ));
          else
            return Center(
                child: Image.asset(
              'images/loading.png',
              fit: BoxFit.fill,
              height: 80,
              width: 80,
            ));

          return Container();
        });
  }
}
