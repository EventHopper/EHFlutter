import 'package:EventHopper/services/state-management/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:EventHopper/components/event_card.dart';
import 'package:EventHopper/constants.dart';
import 'package:EventHopper/models/events/Event.dart';
import 'package:EventHopper/size_config.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Future<List<Event>> events = getEvents();

    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/organization.svg',
              height: getProportionateScreenHeight(180),
            ),
            VerticalSpacing(),
            VerticalSpacing(),
            Container(
                width: getProportionateScreenWidth(300),
                child: Column(
                  children: [
                    Text(
                      "COMING AS SOON AS S3 IS FINISHED :-)",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 23,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    VerticalSpacing(),
                    VerticalSpacing(),
                    Text(
                      "",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        wordSpacing: 1,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey[350],
                        fontSize: 18,
                      ),
                    ),
                  ],
                )),
            VerticalSpacing(),
            VerticalSpacing(),
          ],
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
                color: Colors.blue,
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
