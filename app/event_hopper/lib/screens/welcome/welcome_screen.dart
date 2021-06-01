import 'package:EventHopper/services/state-management/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:EventHopper/screens/welcome/components/figma_body.dart';
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
    Future.delayed(Duration.zero, intializeApp);
  }

  void intializeApp() {
    if (!Provider.of<SessionManager>(context, listen: false)
        .initialStateLoaded) {
      Provider.of<SessionManager>(context, listen: false).fetchEventsNearMe();
      Provider.of<SessionManager>(context, listen: false)
          .updateInitialState(true);
      initSystem();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      extendBodyBehindAppBar: true,
      body: FigmaBody(),
    );
  }

  void getPermissionStatus() async {
    PermissionStatus permission = await Permission.location.status;
    if (permission == PermissionStatus.granted) {
    } // ideally you should specify another condition if permissions is denied
    else if (permission == PermissionStatus.denied ||
        permission == PermissionStatus.permanentlyDenied ||
        permission == PermissionStatus.restricted) {
      try {
        await [Permission.location].request();
      } catch (e) {}
    }
  }

  void initSystem() async {
    getPermissionStatus();
  }
}
