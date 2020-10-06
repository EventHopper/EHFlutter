import 'package:EventHopper/models/users/UserManager.dart';
import 'package:flutter/material.dart';

class User {
  final String username, fullName, image, email;
  List<User> friends;
  final UserManager userManager;

  User(
      {@required this.username,
      @required this.fullName,
      @required this.image,
      @required this.email,
      this.friends,
      this.userManager});
}

// Demo List of Top Travelers
List<User> topTravelers = [user1, user2, user3];

// demo user
User user1 = User(
    fullName: "Ransford",
    image:
        "https://entrepreneurship.wharton.upenn.edu/wp-content/uploads/2019/02/headshot-Ransford-200x200.jpg",
    email: 'ransford@something.com',
    username: 'ransford');
User user2 = User(
    fullName: "Batchema",
    image:
        "https://pbs.twimg.com/profile_images/1113609838502789126/TKvveUDv.png",
    email: 'batchema@something.com',
    username: 'batchema');
User user3 = User(
    fullName: "Kyler",
    image:
        "https://instagram.fphl2-4.fna.fbcdn.net/v/t51.2885-19/s320x320/106558817_862046184321633_3669233856585083655_n.jpg?_nc_ht=instagram.fphl2-4.fna.fbcdn.net&_nc_ohc=KX0xmVyKPQYAX_tKPvM&oh=290b6fbdb50a19aea3b5679fc012376f&oe=5FA1AC4D",
    email: 'kyler@something.com',
    username: 'kyler');
