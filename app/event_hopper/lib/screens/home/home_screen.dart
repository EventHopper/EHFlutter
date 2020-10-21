import 'package:EventHopper/services/state-management/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:EventHopper/components/app_bar.dart';
import 'package:EventHopper/components/custom_bottom_nav_bar.dart';
import 'package:EventHopper/screens/home/components/body.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:EventHopper/components/drawer.dart';
import 'package:provider/provider.dart';
import 'package:package_info/package_info.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    initSystem();
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
    return Scaffold(
      drawer: buildDrawer(context),
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(context, isTransparent: true, title: 'EventHopper'),
      body: Body(),
      bottomNavigationBar: CustomBottonNavBar(),
    );
  }

  void initSystem() async {
    Provider.of<SessionManager>(context).updatePackageInfo();
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
    ].request();
  }
}
