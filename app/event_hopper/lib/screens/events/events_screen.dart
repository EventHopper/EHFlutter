import 'package:EventHopper/components/drawer.dart';
import 'package:EventHopper/screens/route_config.dart';
import 'package:EventHopper/services/state-management/session_manager.dart';
import 'package:EventHopper/utils/screen_navigator.dart';
import 'package:flutter/material.dart';
import 'package:EventHopper/components/app_bar.dart';
import 'package:EventHopper/components/custom_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

import 'components/body.dart';

class EventsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        ScreenNavigator.navigate(context, RouteConfig.home, replace: true);
      },
      child: Scaffold(
        drawer: buildDrawer(context),
        appBar: buildAppBar(context, title: "My Events", color: Colors.black),
        body: Body(),
        bottomNavigationBar: CustomBottonNavBar(),
      ),
    );
  }
}
