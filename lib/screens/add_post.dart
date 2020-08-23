import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/image_picker.dart';
import '../providers/post_model.dart';
import '../providers/posts_provider.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final scriptController = TextEditingController();
  bool _isLoading = false;

  ImageBox _imageWidget ;
  File _image;
  String _imageName ;

  toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    final postsProvider = Provider.of<Posts>(context, listen: false);

    //upload image to fireBase
    Future<void> uploadImage () async {

      StorageReference storageReference = FirebaseStorage.instance.ref().child(_imageName);
      StorageUploadTask uploadTask = storageReference.putFile(_image);

      await uploadTask.onComplete;
      //StorageTaskSnapshot taskSnapshot =

    }

    //when u click on [post] button
    Future<void> submitPost() async {
      try {
        toggleLoading();

        if(_imageName != null) uploadImage();

        await postsProvider.addPost(Post(
            image: _imageName,
            profileName: 'profile1: Ahmed',
            postId: null,
            time: DateTime.now(),
            profileImage: null,
            profileId: 'profile1_ID',
            script: scriptController.text));


        toggleLoading();
        Navigator.pop(context);
      } catch (exception) {
        print(exception.toString() + 'add_post widget');

        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(
            exception.toString(),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black87,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )),
        ));
        toggleLoading();
      }
    }

    //to get an image from gallery
    Future<void> getImage() async {
      File image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _imageWidget = (ImageBox(image));
        _image = image;
        _imageName = basename(_image.path);
      });
    }


    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Color.fromRGBO(0, 125, 0, 1),
          title: Text('Crate post'),
          leading: FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 25,
              )),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: RaisedButton(
                onPressed: submitPost,
                child: Text('Post'),
                color: Colors.green.shade500,
              ),
            )
          ],
        ),
      ),
      body: Stack(children: <Widget>[
        Column(
          children: <Widget>[
            ///profile Row & image button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 25,
                        child: Image.asset(
                          'images/profile.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'post.profileName',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.image),
                        onPressed: getImage,
                      )
                    ],
                  ),
                ),
              ),
            ),

            ///Images Row
            if (_imageWidget != null)
              Container(
                alignment: Alignment.centerRight,
                height: 60,
                child: _imageWidget
              ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Divider(height: 1),
            ),

            Expanded(
              child: Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
//              decoration: BoxDecoration(
//                  border: Border.fromBorderSide(BorderSide(color: Colors.grey)),
//                borderRadius: BorderRadius.circular(10),
//              ),
                child: TextField(
                  controller: scriptController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "whats's in your mind ...",
                  ),
                ),
              ),
            )
          ],
        ),
        if (_isLoading)
          Container(
            color: Color.fromRGBO(0, 0, 0, 0.2),
            //margin: const EdgeInsets.all(value),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
      ]),
    );
  }
}
