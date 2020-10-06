import 'package:EventHopper/screens/route_config.dart';
import 'package:EventHopper/services/state-management/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:EventHopper/utils/system_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:EventHopper/screens/events/events_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:EventHopper/utils/screen_navigator.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../size_config.dart';

class CustomBottonNavBar extends StatelessWidget {
  const CustomBottonNavBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int currentPage = Provider.of<SessionManager>(context).currentPage;
    SizeConfig().init(context);
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavItem(
                icon: FaIcon(FontAwesomeIcons.search).icon,
                title: "Explore",
                isActive: currentPage == 0,
                press: () {
                  Provider.of<SessionManager>(context, listen: false)
                      .updateCurrentPage(0);
                  // Navigator.pushReplacementNamed(context, '/');
                  ScreenNavigator.navigate(context, RouteConfig.home);
                },
              ),
              NavItem(
                icon: FaIcon(FontAwesomeIcons.handPaper).icon,
                title: "Swipe",
                isActive: currentPage == 1,
                press: () {
                  Provider.of<SessionManager>(context, listen: false)
                      .updateCurrentPage(1);
                  ScreenNavigator.navigate(context, RouteConfig.swipe);
                },
              ),
              NavItem(
                icon: FaIcon(FontAwesomeIcons.calendar).icon,
                title: "Events",
                isActive: currentPage == 2,
                press: () {
                  // Navigator.pushReplacementNamed(context, '/myevents');
                  Provider.of<SessionManager>(context, listen: false)
                      .updateCurrentPage(2);
                  ScreenNavigator.navigate(context, RouteConfig.myEvents);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavItem extends StatefulWidget {
  const NavItem({
    Key key,
    @required this.icon,
    @required this.title,
    @required this.press,
    this.isActive = false,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final GestureTapCallback press;
  final bool isActive;

  @override
  _NavItemState createState() => _NavItemState();
}

class _NavItemState extends State<NavItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        SystemUtils.vibrate();
        widget.press();
      },
      child: Container(
        padding: EdgeInsets.all(5),
        height: getProportionateScreenWidth(60),
        width: getProportionateScreenWidth(60),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          // boxShadow: [if (isActive) kDefualtShadow],
        ),
        child: Column(
          children: [
            Icon(
              widget.icon,
              size: 28,
              color: widget.isActive ? kTextColor : Colors.grey,
            ),
            Spacer(),
            Text(
              widget.title,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: widget.isActive ? kTextColor : Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
