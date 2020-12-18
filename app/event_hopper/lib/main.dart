import 'package:EventHopper/screens/calendar/calendar_screen.dart';
import 'package:EventHopper/screens/friends/friends_screen.dart';
import 'package:EventHopper/screens/login/login_screen.dart';
import 'package:EventHopper/screens/organizations/organizations_screen.dart';
import 'package:EventHopper/screens/profile/profile_screen.dart';
import 'package:EventHopper/screens/registration/registration_screen.dart';
import 'package:EventHopper/screens/route_config.dart';
import 'package:EventHopper/screens/settings/settings_screen.dart';
import 'package:EventHopper/screens/swipe/swipe_screen.dart';
import 'package:EventHopper/screens/welcome/welcome_screen.dart';
import 'package:EventHopper/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:EventHopper/utils/constants.dart';
import 'package:EventHopper/screens/home/home_screen.dart';
import 'package:EventHopper/screens/events/events_screen.dart';
import 'package:provider/provider.dart';
import 'services/state-management/session_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 300,
                width: 300,
                child: Text(snapshot.error.toString(),
                    textDirection: TextDirection.ltr),
              ),
            ],
          );
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return mainApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 300,
              width: 300,
              child: SpinKitRotatingCircle(color: kTextColor, size: 50.0),
            ),
          ],
        );
      },
    );
  }

  String getHomeRoute() {
    return FirebaseAuth.instance.currentUser != null ? '/home' : '/welcome';
  }

  Widget mainApp() {
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
        initialRoute: getHomeRoute(),
        routes: {
          RouteConfig.welcome: (context) => WelcomeScreen(),
          RouteConfig.login: (context) => LogInScreen(),
          RouteConfig.registration: (context) => RegistrationScreen(),
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
