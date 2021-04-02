import 'package:EventHopper/models/users/User.dart';
import 'package:EventHopper/screens/route_config.dart';
import 'package:EventHopper/services/state-management/session_manager.dart';
import 'package:EventHopper/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:EventHopper/components/location_banner.dart';
import 'package:provider/provider.dart';
import '../utils/constants.dart';
import 'dart:math';

AppBar buildAppBar(BuildContext context,
    {bool isTransparent = false,
    String title = '',
    Color color,
    Widget leftIcon,
    GlobalKey<ScaffoldState> key,
    Color backButtonColor,

    /// default false
    bool backButton = false,
    bool profileIcon = true,
    bool showLocationBanner = false}) {
  return AppBar(
    backgroundColor: isTransparent ? Colors.transparent : Colors.white,
    elevation: 0,
    leading: backButton
        ? BackButton(
            color: backButtonColor == null ? Colors.black : backButtonColor,
          )
        : leftIcon != null
            ? new FlatButton(
                onPressed: () => key.currentState.openDrawer(), child: leftIcon)
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
      if (profileIcon) UserAvatar(),
    ],
  );
}

class UserAvatar extends StatefulWidget {
  const UserAvatar({
    Key key,
  }) : super(key: key);

  @override
  _UserAvatarState createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
        future: Provider.of<SessionManager>(context, listen: true).currentUser,
        builder: (context, user) {
          return IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteConfig.myProfile);
              },
              icon: user.hasData
                  ? CircleAvatar(
                      backgroundColor: Colors.blueGrey,
                      backgroundImage: NetworkImage(
                        user.data.image,
                      ))
                  : CircleAvatar(
                      backgroundColor: Colors.blueGrey,
                      child: CircularProgressIndicator()));
        });
  }
}
