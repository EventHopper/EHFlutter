import 'package:EventHopper/screens/calendar/calendar_screen.dart';
import 'package:EventHopper/screens/events/events_screen.dart';
import 'package:EventHopper/screens/friends/friends_screen.dart';
import 'package:EventHopper/screens/organizations/organizations_screen.dart';
import 'package:EventHopper/screens/settings/settings_screen.dart';
import 'package:EventHopper/screens/swipe/swipe_screen.dart';
import 'package:EventHopper/screens/home/home_screen.dart';

class RouteConfig {
  static const String home = '/';
  static const String swipe = '/swipe';
  static const String myEvents = '/my-events';
  static const String myProfile = '/profile';
  static const String settings = '/settings';
  static const String organizations = '/organizations';
  static const String calendar = '/calendar';
  static const String friends = '/friends';

  static getPage(String route) {
    switch (route) {
      case RouteConfig.home:
        return HomeScreen();
        break;
      case RouteConfig.swipe:
        return SwipeScreen();
        break;
      case RouteConfig.myEvents:
        return EventsScreen();
        break;
      case RouteConfig.settings:
        return SettingsScreen();
        break;
      case RouteConfig.organizations:
        return OrganizationsScreen();
        break;
      case RouteConfig.calendar:
        return CalendarScreen();
        break;
      case RouteConfig.friends:
        return FriendsScreen();
        break;
    }
  }
}
