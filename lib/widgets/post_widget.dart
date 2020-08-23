import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/post_model.dart';
import 'expandable_text.dart';
import 'load_image.dart';

class PostWidget extends StatelessWidget {
//  final post;
//  const Post( this.post) ;
//final url = 'https://task-1-43cb8.appspot.com/';

  @override
  Widget build(BuildContext context) {
    final post = Provider.of<Post>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4.5),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ///name & profile picture & time
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                          post.profileImage ?? 'images/profile.png',
                          fit: BoxFit.cover
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        post.profileName,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),

                      //TODO: implement date time presentation method
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '${post.time.hour}:${post.time.minute}',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          Text(
                            '${post.time.day}/${post.time.month}',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),

            ///script
            if (post.script != null && post.script.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 10, bottom: 8, top: 5),
                child: ExpandableText(post.script),
              ),

            ///image
            if (post.image != null && post.image.isNotEmpty)

              LoadImage(post.image),

//              SizedBox(
//                // height: 100,
//                child: Image.network(
//                  url + post.image,
//                  fit: BoxFit.cover,
//                ),
//              ),

            ///like & comment
            SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Consumer<Post>(
                      child: Text(' Like',
                          style: TextStyle(color: Colors.grey, fontSize: 14)),
                      builder: (context, post, child) => FlatButton(
                        padding: const EdgeInsets.all(8.0),
                        onPressed: () {
                          post.toggleLike(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            post.isLike
                                ? Icon(Icons.favorite, color: Colors.red)
                                : Icon(Icons.favorite_border,
                                    color: Colors.grey),
                            child
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: VerticalDivider(
                        width: 5,
                        color: Colors.grey,
                      ),
                    ),
                    FlatButton(
                      padding: const EdgeInsets.all(8.0),
                      onPressed: () {},
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.message, color: Colors.grey),
                          Text(
                            ' comment',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
