import 'package:EventHopper/components/app_bar.dart';
import 'package:EventHopper/services/state-management/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:EventHopper/screens/registration/components/body.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  void initState() {
    super.initState();

    if (!Provider.of<SessionManager>(context, listen: false)
        .initialStateLoaded) {
      Provider.of<SessionManager>(context, listen: false)
          .fetchCurrentUserData();
      Provider.of<SessionManager>(context, listen: false).fetchEventsNearMe();
      Provider.of<SessionManager>(context, listen: false)
          .updateInitialState(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(
        context,
        backButton: true,
        isTransparent: true,
        profileIcon: false,
      ),
      body: Body(),
    );
  }
}
