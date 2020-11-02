import 'dart:async';

import 'package:EventHopper/services/state-management/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:EventHopper/components/event_card.dart';
import 'package:EventHopper/components/section_title.dart';
import 'package:EventHopper/models/events/Event.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';

Stream<List<Event>> _events;

class EventsNearYou extends StatefulWidget {
  const EventsNearYou({
    Key key,
  }) : super(key: key);

  @override
  _EventsNearYouState createState() => _EventsNearYouState();
}

class _EventsNearYouState extends State<EventsNearYou> {
  @override
  void initState() {
    super.initState();
    _events = Provider.of<SessionManager>(context, listen: false)
        .eventsNearMe
        .asStream();
  }

  @override
  void didUpdateWidget(EventsNearYou oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          title: "Events Near You",
          press: () {},
        ),
        VerticalSpacing(of: 20),
        SingleChildScrollView(
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            child: StreamBuilder<List<Event>>(
              stream: _events,
              builder: (BuildContext context, events) {
                if (!events.hasData) {
                  return SpinKitRotatingCircle(
                    color: kTextColor,
                    size: 50.0,
                  );
                } else {
                  return Row(
                    children: [
                      ...List.generate(
                        events.data.length,
                        (index) => Padding(
                          padding: EdgeInsets.only(
                              left:
                                  getProportionateScreenWidth(kDefaultPadding)),
                          child: PlaceCard(
                            eventSpotlight: events.data[index],
                            press: () {
                              print(events.data[index].action);
                              _launchURL(events.data[index].action);
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(kDefaultPadding),
                      ),
                    ],
                  );
                }
              },
            ))
      ],
    );
  }
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
