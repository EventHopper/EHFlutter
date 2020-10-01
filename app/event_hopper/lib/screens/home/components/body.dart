import 'package:flutter/material.dart';
import 'package:EventHopper/size_config.dart';

import 'home_header.dart';
import 'events_near_you.dart';
import 'top_categories.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // You have to call SizeConfig on your starting page
    SizeConfig().init(context);
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            HomeHeader(),
            VerticalSpacing(),
            EventsNearYou(),
            VerticalSpacing(),
            EventCategories(),
            VerticalSpacing(),
          ],
        ),
      ),
    );
  }
}
