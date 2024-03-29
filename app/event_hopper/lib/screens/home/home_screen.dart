import 'package:EventHopper/services/state-management/session_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:EventHopper/components/app_bar.dart';
import 'package:EventHopper/components/custom_bottom_nav_bar.dart';
import 'package:EventHopper/screens/home/components/body.dart';
import 'package:EventHopper/components/drawer.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    if (mounted) {
      if (!Provider.of<SessionManager>(context, listen: false)
          .initialStateLoaded) {
        if (FirebaseAuth.instance.currentUser != null) {
          Provider.of<SessionManager>(context, listen: false)
              .fetchCurrentUserData();
        }
        Provider.of<SessionManager>(context, listen: false).fetchEventsNearMe();
        Provider.of<SessionManager>(context, listen: false)
            .updateInitialState(true);
        Provider.of<SessionManager>(context, listen: false)
            .fetchUserEventLists();
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context),
      extendBodyBehindAppBar: true,
      appBar:
          buildAppBar(context, isTransparent: true, showLocationBanner: true),
      body: Body(),
      bottomNavigationBar: CustomBottonNavBar(),
    );
  }
}
