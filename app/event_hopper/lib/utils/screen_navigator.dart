import 'package:EventHopper/services/state-management/session_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:EventHopper/screens/route_config.dart';
import 'package:provider/provider.dart';

class ScreenNavigator {
  /// Given a [context] will transition to a given [widget] with `swipe animation`,
  /// and optionally [replace] current or [replaceAll] page(s) on the nav stack.
  ///
  /// __Note:__ a [replaceAll] takes presidence over a [replace].
  static void widget(BuildContext context, Widget widget,
      {bool replace = false, bool replaceAll = false}) {
    Navigator.push(
        context, CupertinoPageRoute(builder: (BuildContext context) => widget)
        // PageRouteBuilder(
        //     pageBuilder: (context, animation1, animation2) => widget),
        );
  }

  /// Given a [context] will transition to a given [route] with `no animation`,
  /// and optionally [replace] current or [replaceAll] page(s) on the nav stack.
  ///
  /// __Note:__ a [replaceAll] takes presidence over a [replace].
  static void navigate(BuildContext context, String route,
      {bool replace = false, bool replaceAll = false}) {
    _changeCurrentPage(context, route);
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
    Navigator.pushNamedAndRemoveUntil(
        context, RouteConfig.welcome, (Route<dynamic> route) => false);
  }

  static void _changeCurrentPage(BuildContext context, String route) {
    switch (route) {
      case RouteConfig.home:
        Provider.of<SessionManager>(context, listen: false)
            .updateCurrentPage(0);
        break;
      case RouteConfig.swipe:
        Provider.of<SessionManager>(context, listen: false)
            .updateCurrentPage(1);
        break;
      case RouteConfig.myEvents:
        Provider.of<SessionManager>(context, listen: false)
            .updateCurrentPage(2);
        break;
      default:
        break;
    }
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
