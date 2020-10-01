import 'package:flutter/material.dart';
import 'package:EventHopper/components/event_card.dart';
import 'package:EventHopper/components/section_title.dart';
import 'package:EventHopper/models/EventSpotlight.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

Future<List<Event>> _events;

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
    _events = getEvents();
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
            child: FutureBuilder<List<Event>>(
              future: _events,
              builder: (BuildContext context, events) {
                if (events.data == null) {
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
