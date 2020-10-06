import 'package:EventHopper/components/drawer.dart';
import 'package:EventHopper/screens/route_config.dart';
import 'package:EventHopper/screens/swipe/components/experimental/ivaskuu/swipe_feed_page.dart';
import 'package:EventHopper/services/state-management/session_manager.dart';
import 'package:EventHopper/utils/screen_navigator.dart';
import 'package:flutter/material.dart';
import 'package:EventHopper/components/app_bar.dart';
import 'package:EventHopper/components/custom_bottom_nav_bar.dart';
import 'package:EventHopper/screens/swipe/components/experimental/flutter_tindercard/body.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class SwipeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<SwipeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Provider.of<SessionManager>(context, listen: false)
            .updateCurrentPage(0);
        ScreenNavigator.navigate(context, RouteConfig.home);
      },
      child: Scaffold(
        drawer: buildDrawer(context),
        extendBodyBehindAppBar: true,
        appBar: buildAppBar(context, title: 'Swipe', color: Colors.black),
        body: SwipeFeedPage(),
        bottomNavigationBar: CustomBottonNavBar(),
      ),
    );
  }
}
