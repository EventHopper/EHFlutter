import 'package:EventHopper/components/drawer.dart';
import 'package:flutter/material.dart';
import 'package:EventHopper/components/app_bar.dart';

import 'components/body.dart';

class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context),
      appBar: buildAppBar(context,
          title: "Calendar", color: Colors.black, backButton: true),
      body: Body(),
    );
  }
}
