import 'package:EventHopper/screens/route_config.dart';
import 'package:EventHopper/screens/swipe/utils/components/swipe_feed_page.dart';
import 'package:EventHopper/screens/swipe/utils/constants.dart';
import 'package:EventHopper/screens/swipe/utils/pages/event_list.dart';
import 'package:EventHopper/services/state-management/session_manager.dart';
import 'package:EventHopper/utils/constants.dart';
import 'package:EventHopper/utils/screen_navigator.dart';
import 'package:flutter/material.dart';
import 'package:EventHopper/components/app_bar.dart';
import 'package:EventHopper/components/custom_bottom_nav_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:EventHopper/components/count_label.dart';

class SwipeScreen extends StatefulWidget {
  @override
  _SwipeScreenState createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        ScreenNavigator.navigate(context, RouteConfig.home, replace: true);
        return new Future<bool>(() => true);
      },
      child: Scaffold(
        key: _scaffoldKey,
        drawer: buildSwipeDrawer(context),
        extendBodyBehindAppBar: true,
        appBar: buildAppBar(
          context,
          key: _scaffoldKey,
          leftIcon: Stack(
            children: <Widget>[
              SvgPicture.asset(
                'assets/icons/cards.svg',
                height: 40,
                width: 40,
                color: kTextColor,
              ),
              CardCountLabel()
            ],
          ),
          title: 'Swipe',
        ),
        body: SwipeFeedPage(),
        bottomNavigationBar: CustomBottonNavBar(),
      ),
    );
  }
}

class CardCountLabel extends StatefulWidget {
  const CardCountLabel({
    Key key,
  }) : super(key: key);

  @override
  _CardCountLabelState createState() => _CardCountLabelState();
}

class _CardCountLabelState extends State<CardCountLabel> {
  @override
  Widget build(BuildContext context) {
    return new Positioned(
      top: 15,
      child: new Container(
        decoration: new BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(8),
        ),
        constraints: BoxConstraints(
          minWidth: 20,
          minHeight: 20,
        ),
        child: new Text(
          Provider.of<SessionManager>(context, listen: true)
              .eventTotalCount
              .toString(),
          style: new TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

Drawer buildSwipeDrawer(BuildContext context) {
  int upCount = Provider.of<SessionManager>(context, listen: true).eventUpCount;
  int leftCount =
      Provider.of<SessionManager>(context, listen: true).eventLeftCount;
  int rightCount =
      Provider.of<SessionManager>(context, listen: true).eventRightCount;
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
                'Swipe',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.list_alt_rounded),
          title: Text(
            'Shortlist',
            style: TextStyle(fontSize: 16),
          ),
          trailing: CountLabel(upCount, color: kIndicatorUpColor),
          onTap: () {
            Navigator.pop(context);
            ScreenNavigator.widget(
                context,
                EventList(
                    listName: 'Shortlist ($upCount)',
                    eventList:
                        Provider.of<SessionManager>(context, listen: false)
                            .eventUp));
          },
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.star),
          title: Text(
            'Saved',
            style: TextStyle(fontSize: 16),
          ),
          trailing: CountLabel(
            rightCount,
            color: kIndicatorRightColor,
          ),
          onTap: () {
            Navigator.pop(context);
            ScreenNavigator.widget(
                context,
                EventList(
                    listName: 'Saved ($rightCount)',
                    eventList:
                        Provider.of<SessionManager>(context, listen: false)
                            .eventRight));
          },
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.trash),
          title: Text(
            'Bin',
            style: TextStyle(fontSize: 16),
          ),
          trailing: CountLabel(leftCount, color: kIndicatorLeftColor),
          onTap: () {
            Navigator.pop(context);
            ScreenNavigator.widget(
                context,
                EventList(
                    listName: 'Bin ($leftCount)',
                    eventList:
                        Provider.of<SessionManager>(context, listen: false)
                            .eventLeft));
          },
        ),
      ],
    ),
  );
}
