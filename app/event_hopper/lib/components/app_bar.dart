import 'package:flutter/material.dart';

import '../constants.dart';

AppBar buildAppBar(BuildContext context,
    {bool isTransparent = false, String title, Color color}) {
  return AppBar(
    backgroundColor: isTransparent ? Colors.transparent : Colors.white,
    elevation: 0,
    leading: IconButton(
      icon: Icon(
        Icons.menu,
        color: color != null ? color : Colors.white,
      ),
      onPressed: () {},
    ),
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
                "https://i1.rgstatic.net/ii/profile.image/773438742487040-1561413574079_Q512/Kyler_Mintah.jpg")),
        onPressed: () {},
      )
    ],
  );
}
