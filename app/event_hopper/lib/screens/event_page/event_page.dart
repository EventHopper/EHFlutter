import 'package:EventHopper/models/events/Event.dart';
import 'package:EventHopper/screens/swipe/utils/constants.dart';
import 'package:EventHopper/utils/size_config.dart';
import 'package:EventHopper/utils/system_utils.dart';
import 'package:flutter/material.dart';
import 'package:EventHopper/components/app_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class EventPage extends StatelessWidget {
  final Event event;
  EventPage({
    this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(context,
          backButton: true,
          title: '',
          profileIcon: false,
          isTransparent: true,
          backButtonColor: Colors.white),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Hero(
                tag: kEventPageHeroTag,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Image.network(
                      this.event.image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: getProportionateScreenHeight(315),
                      filterQuality: FilterQuality.high,
                    ),
                    ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.6), BlendMode.dstATop),
                      child: Container(
                        height: getProportionateScreenHeight(315),
                        width: double.infinity,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: getProportionateScreenHeight(150)),
                          Material(
                            color: Colors.transparent,
                            child: Text(
                              this.event.name,
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(36),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  height: 0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              VerticalSpacing(),

              // Date & Time
              ListTile(
                leading: Container(
                  height: 60,
                  width: 30,
                  child: Icon(FontAwesomeIcons.calendar),
                ),
                title: Text(
                  '${this.event.date.toLocal().hour.toString() + ":" + this.event.date.toLocal().minute.toString()}\n${this.event.date.day.toString() + " " + DateFormat.MMMM().format(this.event.date) + " " + this.event.date.year.toString()}',
                ),
                onTap: () async {},
              ),
              VerticalSpacing(),

              // Venue
              ListTile(
                trailing: Container(
                    width: 60,
                    height: 50,
                    child: Image.network(
                      this.event.venue.imageURL,
                    )),
                leading: Container(
                  height: 60,
                  width: 30,
                  child: Icon(FontAwesomeIcons.locationArrow),
                ),
                title: Text(
                  '${this.event.venue.toString()}',
                ),
                onTap: () async {
                  launchURL(
                      'https://www.google.com/maps/search/?api=1&query=${this.event.venue.toQueryString()}');
                },
              ),
              VerticalSpacing(),

              // Visit Ticket Provider
              ListTile(
                leading: Container(
                  height: 30,
                  width: 10,
                ),
                title: Text(
                  'visit ticket provider',
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {
                  launchURL(this.event.action);
                },
              ),
              VerticalSpacing(),

              // Additional Information
              ListTile(
                leading: Container(
                  height: 60,
                  width: 30,
                  child: Icon(FontAwesomeIcons.infoCircle),
                ),
                dense: true,
                title: Text(
                  'Additional Info',
                  style: TextStyle(fontSize: getProportionateScreenWidth(20)),
                ),
                subtitle: this.event.description != 'Please swipe for more info'
                    ? Text(
                        '${this.event.description}',
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(14)),
                      )
                    : Text(
                        'Visit ticket provider for more details.',
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(14)),
                      ),
                onTap: () {},
              ),
              VerticalSpacing(),
            ],
          ),
        ),
      ),
    );
  }
}
