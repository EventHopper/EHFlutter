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
        "https://scontent-lga3-1.cdninstagram.com/v/t51.2885-19/s320x320/106558817_862046184321633_3669233856585083655_n.jpg?_nc_ht=scontent-lga3-1.cdninstagram.com&_nc_ohc=AQ30HpbB2DUAX9Hdx67&tp=1&oh=53db9920513b95894d9b476b46884c76&oe=5FE4E8CD",
    email: 'kyler@something.com',
    username: 'kyler');
// User user4 = User(
//     fullName: "Mo",
//     image:
//         "https://s.yimg.com/ny/api/res/1.2/12UU2JphAsbxTTDca.7QFQ--~A/YXBwaWQ9aGlnaGxhbmRlcjtzbT0xO3c9MTA4MDtoPTcxNg--/https://media-mbst-pub-ue1.s3.amazonaws.com/creatr-uploaded-images/2019-11/7b5b5330-112b-11ea-a77f-7c019be7ecae",
//     email: 'mo@something.com',
//     username: 'MoMoney');
