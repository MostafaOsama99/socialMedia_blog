import 'providers/post_model.dart';

List<Post> demoPosts = [
  Post(
      profileId: '1',
      profileName: 'profile 1',
      postId: '01',
      image: 'images/pic (1).jpg',
      time: DateTime.now().subtract(Duration(days: 1, hours: 2, minutes: 10)),
      script: '''this is a test script for this post. \n this post maybe about a car\n 
      \n\n\n\n\n\n\nchick this out https://stackoverflow.com/questions/49572747/flutter-how-to-hide-or-show-more-text-within-certain-length 
      i hope you find the solution her\n best wishes. 
      ''',
      profileImage: 'images/profile.png'),

  Post(
      profileId: '2',
      profileName: 'profile 2',
      postId: '02',
      image: 'images/pic (2).jpg',
      time: DateTime.now().subtract(Duration(days: 2, hours: 4, minutes: 20)),
      script: 'this is a test script for this post. \n this post maybe about a car',
      profileImage: 'images/profile.png'),

  Post(
      profileId: '3',
      profileName: 'profile 3',
      postId: '03',
      image: 'images/pic (3).jpg',
      time: DateTime.now().subtract(Duration(days: 3, hours: 5, minutes: 30)),
      script: 'this is a test script for this post. this post maybe about a car or cartoon \ndo you like despicable me ? ',
      profileImage: 'images/profile.png'),

  Post(
      profileId: '4',
      profileName: 'profile 4',
      postId: '04',
      image: 'images/pic (4).jpg',
      time: DateTime.now().subtract(Duration(days: 4, hours: 8, minutes: 40)),
      script: 'this is a test script for this post. \n this post maybe about a car',
      profileImage: 'images/profile.png'),

  Post(
      profileId: '5',
      profileName: 'profile 5',
      postId: '05',
      image: 'images/pic (5).jpg',
      time: DateTime.now().subtract(Duration(days: 5, hours: 10, minutes: 50)),
      script: 'this is a test script for this post. \n this post maybe about a car',
      profileImage: 'images/profile.png'),

  Post(
      profileId: '6',
      profileName: 'profile 6',
      postId: '06',
      image: 'images/pic (6).jpg',
      time: DateTime.now().subtract(Duration(days: 6, hours: 12, minutes: 17)),
      script: null,//'this is a test script for this post. \n this post maybe about a car',
      profileImage: 'images/profile.png'),
];
