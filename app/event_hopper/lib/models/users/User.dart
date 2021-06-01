import 'dart:convert';

import 'package:EventHopper/models/users/UserManager.dart';
import 'package:flutter/material.dart';

class User {
  final String username, fullName, email, id;
  var image;
  List<User> friends;
  final UserManager userManager;
  static const String defaultImage =
      'https://conceptdraw.com/a155c4/p149/preview/640/pict--schedule-cloud-round-icons-vector-stencils-library';

  User(
      {@required this.id,
      @required this.username,
      @required this.fullName,
      @required this.image,
      @required this.email,
      this.friends,
      this.userManager});

  factory User.fromJson(Map<String, dynamic> json) {
    print(json);
    return User(
      id: json['user_id'] as String,
      username: json['username'] as String,
      fullName: json['full_name'] as String,
      image: json['image_url'] != null
          ? json['image_url'] as String
          : defaultImage,
      email: json['email'],
    );
  }
}

// Demo List of Top Travelers
List<User> topTravelers = [user1, user2, user3];

// demo user
User user1 = User(
    id: 'test-1',
    fullName: "Ransford",
    image:
        "https://entrepreneurship.wharton.upenn.edu/wp-content/uploads/2019/02/headshot-Ransford-200x200.jpg",
    email: 'ransford@something.com',
    username: 'ransford');
User user2 = User(
    id: 'test-2',
    fullName: "Batchema",
    image:
        "https://pbs.twimg.com/profile_images/1113609838502789126/TKvveUDv.png",
    email: 'batchema@something.com',
    username: 'batchema');
User user3 = User(
    id: 'test-3',
    fullName: "Kyler",
    image:
        "https://pbs.twimg.com/profile_images/1215038784913510400/fZAZQwmh_400x400.jpg",
    email: 'kyler@something.com',
    username: 'kyler');
// User user4 = User(
//     fullName: "Mo",
//     image:
//         "https://s.yimg.com/ny/api/res/1.2/12UU2JphAsbxTTDca.7QFQ--~A/YXBwaWQ9aGlnaGxhbmRlcjtzbT0xO3c9MTA4MDtoPTcxNg--/https://media-mbst-pub-ue1.s3.amazonaws.com/creatr-uploaded-images/2019-11/7b5b5330-112b-11ea-a77f-7c019be7ecae",
//     email: 'mo@something.com',
//     username: 'MoMoney');
