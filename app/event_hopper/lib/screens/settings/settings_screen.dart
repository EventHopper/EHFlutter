import 'package:EventHopper/components/drawer.dart';
import 'package:EventHopper/screens/route_config.dart';
import 'package:EventHopper/services/state-management/session_manager.dart';
import 'package:EventHopper/utils/screen_navigator.dart';
import 'package:flutter/material.dart';
import 'package:EventHopper/components/app_bar.dart';
import 'package:EventHopper/components/custom_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

import 'components/body.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context),
      appBar: buildAppBar(context,
          title: "Settings", color: Colors.black, backButton: true),
      body: Body(),
    );
  }
}
