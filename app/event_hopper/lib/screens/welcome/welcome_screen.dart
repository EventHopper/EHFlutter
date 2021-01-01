import 'package:EventHopper/services/state-management/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:EventHopper/screens/welcome/components/body.dart';
import 'package:permission_handler/permission_handler.dart';
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

  void getPermissionStatus() async {
    PermissionStatus permission = await Permission.location.status;
    if (permission == PermissionStatus.granted) {
    } // ideally you should specify another condition if permissions is denied
    else if (permission == PermissionStatus.denied ||
        permission == PermissionStatus.permanentlyDenied ||
        permission == PermissionStatus.restricted ||
        permission == PermissionStatus.undetermined) {
      try {
        await [Permission.location].request();
      } catch (e) {}
    }
  }

  void initSystem() async {
    Provider.of<SessionManager>(context).updatePackageInfo();
    getPermissionStatus();
  }
}
