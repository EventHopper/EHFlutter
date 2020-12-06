import 'package:EventHopper/components/drawer.dart';
import 'package:EventHopper/screens/route_config.dart';
import 'package:EventHopper/screens/swipe/components/experimental/ivaskuu/swipe_feed_page.dart';
import 'package:EventHopper/services/state-management/session_manager.dart';
import 'package:EventHopper/utils/constants.dart';
import 'package:EventHopper/utils/screen_navigator.dart';
import 'package:EventHopper/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:EventHopper/components/app_bar.dart';
import 'package:EventHopper/components/custom_bottom_nav_bar.dart';
import 'package:EventHopper/screens/swipe/components/experimental/flutter_tindercard/body.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class SwipeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<SwipeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
        key: _scaffoldKey,
        drawer: buildSwipeDrawer(context),
        extendBodyBehindAppBar: true,
        appBar: buildAppBar(
          context,
          key: _scaffoldKey,
          leftIcon: SvgPicture.asset(
            'assets/icons/cards.svg',
            height: 25,
            width: 25,
            color: kTextColor,
          ),
          title: 'Swipe',
        ),
        body: SwipeFeedPage(),
        bottomNavigationBar: CustomBottonNavBar(),
      ),
    );
  }
}

Drawer buildSwipeDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 40, 0, 40),
            child: SizedBox(
              height: 40,
              width: 40,
              // child: Text(
              //   'EventHopper',
              //   style: TextStyle(
              //     color: Colors.black,
              //     fontSize: 24,
              //   ),
              // ),
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.list_alt_rounded),
          title: Text(
            'Shortlist',
            style: TextStyle(fontSize: 16),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, RouteConfig.myProfile);
          },
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.star),
          title: Text(
            'Saved',
            style: TextStyle(fontSize: 16),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, RouteConfig.friends);
          },
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.trash),
          title: Text(
            'Bin',
            style: TextStyle(fontSize: 16),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, RouteConfig.calendar);
          },
        ),
      ],
    ),
  );
}
