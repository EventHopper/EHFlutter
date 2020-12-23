import 'package:EventHopper/components/drawer.dart';
import 'package:EventHopper/models/events/Event.dart';
import 'package:EventHopper/utils/size_config.dart';
import 'package:EventHopper/utils/system_utils.dart';
import 'package:flutter/material.dart';
import 'package:EventHopper/components/app_bar.dart';

import 'utils/components/body.dart';

class EventScreen extends StatelessWidget {
  final Event event;
  EventScreen({
    this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          buildAppBar(context, backButton: true, title: '', profileIcon: false),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              VerticalSpacing(),
              VerticalSpacing(),
              Container(child: Image.network(this.event.image)),
              ListTile(
                leading: Container(
                  height: 30,
                  width: 10,
                ),
                title: Text(
                  '${this.event.name}',
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Container(
                  height: 30,
                  width: 10,
                ),
                title: Text(
                  '${this.event.date}',
                ),
                onTap: () async {},
              ),
              ListTile(
                leading: Container(
                  height: 60,
                  width: 30,
                ),
                title: Text(
                  '${this.event.venue.toString()}',
                ),
                onTap: () async {
                  launchURL(
                      'https://www.google.com/maps/search/?api=1&query=${this.event.venue.toQueryString()}');
                },
              ),
              ListTile(
                leading: Container(
                  height: 30,
                  width: 10,
                ),
                title: Text(
                  'Visit ticket provider',
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {
                  launchURL(this.event.action);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
