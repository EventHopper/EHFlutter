import 'package:EventHopper/screens/route_config.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

AppBar buildAppBar(BuildContext context,
    {bool isTransparent = false,
    String title,
    Color color,
    bool backButton = false}) {
  return AppBar(
    backgroundColor: isTransparent ? Colors.transparent : Colors.white,
    elevation: 0,
    // leading: backButton ? FaIcon(FontAwesomeIcons.backward) : Icons.menu,
    leading: backButton
        ? BackButton(
            color: Colors.black,
          )
        : null,
    title: !isTransparent
        ? Text(
            isTransparent ? "" : title,
            style: TextStyle(color: kTextColor),
          )
        : null,
    centerTitle: true,
    actions: [
      //User Profile Photo
      IconButton(
        icon: ClipOval(
            child: Image.network(
                "https://instagram.fphl2-4.fna.fbcdn.net/v/t51.2885-19/s320x320/106558817_862046184321633_3669233856585083655_n.jpg?_nc_ht=instagram.fphl2-4.fna.fbcdn.net&_nc_ohc=KX0xmVyKPQYAX_tKPvM&oh=290b6fbdb50a19aea3b5679fc012376f&oe=5FA1AC4D")),
        onPressed: () {
          Navigator.pushNamed(context, RouteConfig.myProfile);
        },
      )
    ],
  );
}
