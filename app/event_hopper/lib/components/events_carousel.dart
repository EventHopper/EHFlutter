import 'dart:async';

import 'package:flutter/material.dart';
import 'package:EventHopper/components/event_card.dart';
import 'package:EventHopper/components/section_title.dart';
import 'package:EventHopper/models/events/Event.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/constants.dart';
import '../utils/size_config.dart';

class EventsCarousel extends StatefulWidget {
  final Stream<List<Event>> events;
  final SectionTitle sectionTitle;

  const EventsCarousel({
    Key key,
    this.events,
    @required this.sectionTitle,
  }) : super(key: key);

  @override
  _EventsCarouselState createState() => _EventsCarouselState();
}

class _EventsCarouselState extends State<EventsCarousel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(EventsCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.sectionTitle,
        VerticalSpacing(of: 20),
        SingleChildScrollView(
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            child: StreamBuilder<List<Event>>(
              stream: widget.events,
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
                          child: EventCard(
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
