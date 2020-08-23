import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task1/providers/posts_provider.dart';

import 'screens/homePage.dart';
import 'screens/add_post.dart';
import 'screens/photo_viewer.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(value: Posts(), child: MaterialApp(
      home: HomePage(),
      routes: {
        'AddPost': (context) => AddPost(),
        'photoViewer': (context)=> PhotoViewer()
      },
    ),);
  }
}
