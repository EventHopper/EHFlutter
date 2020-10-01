import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:EventHopper/screens/events/events_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';
import '../size_config.dart';

class CustomBottonNavBar extends StatelessWidget {
  const CustomBottonNavBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                press: () {},
              ),
              NavItem(
                icon: FaIcon(FontAwesomeIcons.handPaper).icon,
                title: "Swipe",
                press: () {},
              ),
              NavItem(
                icon: FaIcon(FontAwesomeIcons.calendar).icon,
                title: "Events",
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventsScreen(),
                      ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavItem extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        padding: EdgeInsets.all(5),
        height: getProportionateScreenWidth(60),
        width: getProportionateScreenWidth(60),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [if (isActive) kDefualtShadow],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 28,
              color: kTextColor,
            ),
            // SvgPicture.asset(
            //   icon,
            //   color: kTextColor,
            //   height: 28,
            // ),
            Spacer(),
            Text(
              title,
              style: TextStyle(
                  fontSize: 11, fontWeight: FontWeight.bold, color: kTextColor),
            )
          ],
        ),
      ),
    );
  }
}
