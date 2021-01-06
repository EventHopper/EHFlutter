import 'package:EventHopper/components/app_bar.dart';
import 'package:EventHopper/services/state-management/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:EventHopper/components/event_card.dart';
import 'package:EventHopper/utils/constants.dart';
import 'package:EventHopper/models/events/Event.dart';
import 'package:EventHopper/utils/size_config.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class EventList extends StatefulWidget {
  List<Event> eventList = new List();
  String listName;
  EventList({@required this.eventList, this.listName = ''});

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Future<List<Event>> events = getEvents();

    return Scaffold(
      appBar: buildAppBar(context,
          backButton: true,
          title: widget.listName != null ? widget.listName : '',
          profileIcon: false),
      body: SizedBox(
        width: SizeConfig.screenWidth,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(25)),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: 25),
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                runSpacing: 25,
                children: [
                  ...List.generate(
                    widget.eventList.length,
                    (index) => EventCard(
                      eventSpotlight: widget.eventList[index],
                      isFullCard: true,
                      press: () {},
                    ),
                  ),
                  AddNewEventCard(),
                ],
              ),
            ),
          ),
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
