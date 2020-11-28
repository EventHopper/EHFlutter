import 'package:EventHopper/screens/route_config.dart';
import 'package:flutter/material.dart';
import 'package:EventHopper/components/location_banner.dart';
import '../utils/constants.dart';

AppBar buildAppBar(BuildContext context,
    {bool isTransparent = false,
    String title,
    Color color,

    /// default false
    bool backButton = false,
    bool rightIcon = true,
    bool showLocationBanner = false}) {
  return AppBar(
    backgroundColor: isTransparent ? Colors.transparent : Colors.white,
    elevation: 0,
    // leading: backButton ? FaIcon(FontAwesomeIcons.backward) : Icons.menu,
    leading: backButton
        ? BackButton(
            color: Colors.black,
          )
        : null,
    title: showLocationBanner
        ? LocationBanner()
        : !isTransparent
            ? Text(
                isTransparent ? "" : title,
                style: TextStyle(color: kTextColor),
              )
            : null,
    centerTitle: true,
    actions: [
      //User Profile Photo
      rightIcon
          ? IconButton(
              icon: ClipOval(
                  child: Image.network(
                      "https://pbs.twimg.com/profile_images/1215038784913510400/fZAZQwmh_400x400.jpg")),
              onPressed: () {
                Navigator.pushNamed(context, RouteConfig.myProfile);
              },
            )
          : Container()
    ],
  );
}
