import 'package:EventHopper/screens/route_config.dart';
import 'package:EventHopper/services/state-management/session_manager.dart';
import 'package:EventHopper/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

Drawer buildDrawer(BuildContext context) {
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
              child: Text(
                'EventHopper',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('Profile'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, RouteConfig.myProfile);
          },
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.userFriends),
          title: Text('Friends'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, RouteConfig.friends);
          },
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.calendarDay),
          title: Text('Calendar'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, RouteConfig.calendar);
          },
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.building),
          title: Text('Communities'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, RouteConfig.organizations);
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Settings & Privacy'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, RouteConfig.settings);
          },
        ),
        VerticalSpacing(),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0, 0),
          child: Container(
              width: 40,
              height: 50,
              alignment: AlignmentDirectional.centerStart,
              child: StateText()),
        )
      ],
    ),
  );
}

class StateText extends StatefulWidget {
  const StateText({
    Key key,
  }) : super(key: key);

  @override
  _StateTextState createState() => _StateTextState();
}

class _StateTextState extends State<StateText> {
  @override
  Widget build(BuildContext context) {
    PackageInfo info =
        Provider.of<SessionManager>(context, listen: true).packageInfo;

    return Text(
      "© EventHopper 2020 \n${info != null ? info.buildNumber : 'unknown'}",
      style: TextStyle(
        color: Colors.grey,
      ),
    );
  }
}
