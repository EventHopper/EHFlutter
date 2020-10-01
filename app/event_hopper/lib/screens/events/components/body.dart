import 'package:flutter/material.dart';
import 'package:EventHopper/components/event_card.dart';
import 'package:EventHopper/constants.dart';
import 'package:EventHopper/models/EventSpotlight.dart';
import 'package:EventHopper/size_config.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Future<List<Event>> _events;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
    _events = getEvents();
  }

  @override
  Widget build(BuildContext context) {
    // Future<List<Event>> events = getEvents();

    return SizedBox(
      width: SizeConfig.screenWidth,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(25)),
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.only(bottom: 25),
              child: FutureBuilder<List<Event>>(
                  future: _events,
                  builder: (BuildContext context, events) {
                    if (events.data == null) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: getProportionateScreenHeight(600),
                            child: SpinKitRotatingCircle(
                              color: kTextColor,
                              size: 50.0,
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        runSpacing: 25,
                        children: [
                          ...List.generate(
                            events.data.length,
                            (index) => PlaceCard(
                              eventSpotlight: events.data[index],
                              isFullCard: true,
                              press: () {},
                            ),
                          ),
                          AddNewEventCard(),
                        ],
                      );
                    }
                  })),
        ),
      ),
    );
  }
}

class AddNewEventCard extends StatelessWidget {
  const AddNewEventCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenWidth(350),
      width: getProportionateScreenWidth(158),
      decoration: BoxDecoration(
        color: Color(0xFF6A6C93).withOpacity(0.09),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 2,
          color: Color(0xFFEBE8F6),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: getProportionateScreenWidth(53),
            width: getProportionateScreenWidth(53),
            child: FlatButton(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60),
              ),
              color: kPrimaryColor,
              onPressed: () {},
              child: Icon(
                Icons.add,
                size: getProportionateScreenWidth(35),
                color: Colors.white,
              ),
            ),
          ),
          VerticalSpacing(of: 10),
          Text(
            "Add New Event",
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
