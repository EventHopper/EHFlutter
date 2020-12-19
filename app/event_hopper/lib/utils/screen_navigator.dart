import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:EventHopper/screens/route_config.dart';

class ScreenNavigator {
  /// Given a [context] will transition to a given [route] with `no animation`,
  /// and optionally [replace] current or [replaceAll] page(s) on the nav stack.
  ///
  /// __Note:__ a [replaceAll] takes presidence over a [replace].
  static void navigate(BuildContext context, String route,
      {bool replace = false, bool replaceAll = false}) {
    replaceAll
        ? Navigator.pushAndRemoveUntil(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  RouteConfig.getPage(route),
            ),
            (Route<dynamic> route) => false)
        : replace
            ? Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      RouteConfig.getPage(route),
                ),
              )
            : Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      RouteConfig.getPage(route),
                ),
              );
  }

  /// Given a [context] will transition to a given [route] with `swipe animation`,
  /// and optionally [replace] current or [replaceAll] page(s) on the nav stack.
  ///
  /// __Note:__ a [replaceAll] takes presidence over a [replace].
  static void navigateSwipe(BuildContext context, String route,
      {bool replace = false, bool replaceAll = false}) {
    replaceAll
        ? Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(
                builder: (BuildContext context) => RouteConfig.getPage(route)),
            (Route<dynamic> route) => false)
        : replace
            ? Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                    builder: (BuildContext context) =>
                        RouteConfig.getPage(route)))
            : Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (BuildContext context) =>
                        RouteConfig.getPage(route)));
  }

  /// Given a [context] will transition user to initial route to simualte log out.
  ///
  /// __Note: Must be called with a state-level logout call to effectively log user out__
  static void navigateLogOut(
    BuildContext context,
  ) {
    Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(
            builder: (BuildContext context) =>
                RouteConfig.getPage(RouteConfig.welcome)),
        (Route<dynamic> route) => false);
  }
}

/// Transitions */

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
