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

  static void navigateSwipe(
    BuildContext context,
    String route,
  ) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => RouteConfig.getPage(route)));
  }
}

/**Transitions */

class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
