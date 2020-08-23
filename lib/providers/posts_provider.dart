import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'post_model.dart';
import '../models/http_exception.dart';

class Posts with ChangeNotifier {
  List<Post> _posts = [];

  List<Post> get posts => [..._posts];

  addPost(Post post) async {
    final url = 'https://task-1-43cb8.firebaseio.com/posts.json';
    try {
      final response = await http.post(url,
          body: json.encode({
            //'profileImage' : post.profileImage,
            'image': post.image,
            'script': post.script.trim(),
            'profileId': post.profileId,
            'profileName': post.profileName,
            'time': post.time.toIso8601String(),
            'isLike': post.isLike
          }));

      if (response.statusCode >= 400) throw (HttpException('Network error'));

      _posts.insert(
          0,
          Post(
              image: post.image,
              profileId: post.postId,
              script: post.script,
              profileName: post.profileName,
              postId: json.decode(response.body).toString(),
              time: post.time,
              profileImage: post.profileImage));
      notifyListeners();
    } catch (e) {
      print(e);
      throw (HttpException(e.toString()));
    }
  }

  Future<void> fetchPosts() async {
    final String url = 'https://task-1-43cb8.firebaseio.com/posts.json';
    try {
      final response = await http.get(url);
      if(response.statusCode >= 400) throw(HttpException('Network Error'));

      List<Post> loadedPosts = [];

      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if(extractedData == null)
        return;

      extractedData.forEach((postId, value) {
        loadedPosts.insert(0,
            Post(
                postId: postId,
                isLike: value['isLike'],
                image: value['image'],
                profileName: value['profileName'],
                time: DateTime.parse(value['time']),
                profileImage: value['profileImage'],
                profileId: null, // value['profileId'],
                script: value['script']));
      });

      _posts = loadedPosts;
      notifyListeners();
    } catch (e) {
      throw (HttpException(e.toString()));
    }
  }

  ///under developing
//  toggleLike(String postId, bool isLike){
//    try{
//      final url = 'https://task-1-43cb8.firebaseio.com/posts/.json';
//
//      var post = _posts.firstWhere((element) => element.postId == postId );
//
//      http.patch(url,body: json.encode({postId:{
//        'isLike':isLike
//
//      }}));
//
//     // int postIndex = _posts.indexWhere((element) => element.postId == postId);
////
////      _posts[postIndex].isLike = isLike ;
//
//    }catch(e){}
//  }

}
