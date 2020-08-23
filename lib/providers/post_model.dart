import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import '../providers/posts_provider.dart';

class Post with ChangeNotifier {
  final String profileId, postId, profileName, image, script, profileImage;
  final DateTime time;
  bool isLike;

  List _comments;

  Post({
    @required this.profileImage,
    @required this.script,
    @required this.image,
    @required this.profileId,
    @required this.postId,
    @required this.profileName,
    @required this.time,
    this.isLike = false,
  });

  toggleLike(context) {
    //TODO: update like status
    isLike = !isLike;
    ///under developing
    //Provider.of<Posts>(context,listen: false).toggleLike(postId, isLike);
    notifyListeners();
  }

  get comments {
    //TODO: load comments logic
    return _comments;
  }
}
