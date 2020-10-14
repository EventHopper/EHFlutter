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
                "https://pbs.twimg.com/profile_images/1215038784913510400/fZAZQwmh_400x400.jpg")),
        onPressed: () {
          Navigator.pushNamed(context, RouteConfig.myProfile);
        },
      )
    ],
  );
}
