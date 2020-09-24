import 'package:flutter/material.dart';

class User {
  final String name, image;

  User({@required this.name, @required this.image});
}

// Demo List of Top Travelers
List<User> topTravelers = [user1, user2, user3];

// demo user
User user1 = User(
    name: "Ransford",
    image:
        "https://entrepreneurship.wharton.upenn.edu/wp-content/uploads/2019/02/headshot-Ransford-200x200.jpg");
User user2 = User(
    name: "Batchema",
    image:
        "https://pbs.twimg.com/profile_images/1113609838502789126/TKvveUDv.png");
User user3 = User(
    name: "Kyler",
    image:
        "https://i1.rgstatic.net/ii/profile.image/773438742487040-1561413574079_Q512/Kyler_Mintah.jpg");
