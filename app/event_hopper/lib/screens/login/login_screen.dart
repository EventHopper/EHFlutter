import 'package:EventHopper/services/state-management/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:EventHopper/screens/login/components/body.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
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
