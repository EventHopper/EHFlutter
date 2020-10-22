import 'package:EventHopper/services/state-management/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:EventHopper/components/app_bar.dart';
import 'package:EventHopper/components/custom_bottom_nav_bar.dart';
import 'package:EventHopper/screens/welcome/components/body.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:EventHopper/components/drawer.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();

    if (!Provider.of<SessionManager>(context, listen: false)
        .initialStateLoaded) {
      Provider.of<SessionManager>(context, listen: false).fetchEventsNearMe();
      Provider.of<SessionManager>(context, listen: false)
          .updateInitialState(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    initSystem();
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Body(),
    );
  }

  void initSystem() async {
    Provider.of<SessionManager>(context).updatePackageInfo();
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
    ].request();
  }
}
