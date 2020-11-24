import 'package:EventHopper/screens/calendar/calendar_screen.dart';
import 'package:EventHopper/screens/friends/friends_screen.dart';
import 'package:EventHopper/screens/login/login_screen.dart';
import 'package:EventHopper/screens/organizations/organizations_screen.dart';
import 'package:EventHopper/screens/profile/profile_screen.dart';
import 'package:EventHopper/screens/route_config.dart';
import 'package:EventHopper/screens/settings/settings_screen.dart';
import 'package:EventHopper/screens/swipe/swipe_screen.dart';
import 'package:EventHopper/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:EventHopper/utils/constants.dart';
import 'package:EventHopper/screens/home/home_screen.dart';
import 'package:EventHopper/screens/events/events_screen.dart';
import 'package:provider/provider.dart';
import 'services/state-management/session_manager.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ChangeNotifierProvider<SessionManager>(
      create: (context) => SessionManager(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'EventHopper',
        theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.white,
          textTheme:
              GoogleFonts.poppinsTextTheme().apply(displayColor: kTextColor),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // home: HomeScreen(),
        initialRoute: '/welcome',
        routes: {
          RouteConfig.welcome: (context) => WelcomeScreen(),
          RouteConfig.login: (context) => LogInScreen(),
          RouteConfig.home: (context) => HomeScreen(),
          RouteConfig.myProfile: (context) => ProfileScreen(),
          RouteConfig.swipe: (context) => SwipeScreen(),
          RouteConfig.myEvents: (context) => EventsScreen(),
          RouteConfig.settings: (context) => SettingsScreen(),
          RouteConfig.organizations: (context) => OrganizationsScreen(),
          RouteConfig.friends: (context) => FriendsScreen(),
          RouteConfig.calendar: (context) => CalendarScreen(),
        },
      ),
    );
  }
}
