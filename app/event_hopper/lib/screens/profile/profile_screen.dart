import 'package:EventHopper/components/drawer.dart';
import 'package:flutter/material.dart';
import 'package:EventHopper/components/app_bar.dart';

import 'components/profile_body.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context),
      appBar: buildAppBar(context,
          title: "", color: Colors.black, backButton: true, profileIcon: false),
      body: ProfileBody(),
    );
  }
}
