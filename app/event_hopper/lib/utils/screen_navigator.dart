import 'package:flutter/material.dart';
import 'package:EventHopper/screens/route_config.dart';

class ScreenNavigator {
  static void navigate(
    BuildContext context,
    String route,
  ) {
    // Navigator.pushReplacementNamed(context, route);

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) =>
            RouteConfig.getPage(route),
      ),
    );
  }
}
