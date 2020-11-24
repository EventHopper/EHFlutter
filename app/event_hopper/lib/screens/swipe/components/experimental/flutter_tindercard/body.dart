import 'package:flutter/material.dart';
import 'package:EventHopper/components/event_card.dart';
import 'package:EventHopper/utils/constants.dart';
import 'package:EventHopper/models/events/Event.dart';
import 'package:EventHopper/utils/size_config.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:EventHopper/services/eh-server/api_service.dart';

Future<List<Event>> _events;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
    _events = apiService.getEventsByCity('Philadelphia');
  }

  @override
  Widget build(BuildContext context) {
    // Future<List<Event>> events = getEvents();
    List<String> welcomeImages = [
      "https://www.nba.com/images/cms/2020-09/lebron-james-jimmy-butler-positioning-eyes-ahead.jpg?w=1920&h=1080",
      "https://static01.nyt.com/images/2020/03/12/arts/12virus-concerts1/12virus-concerts1-videoSixteenByNineJumbo1600-v2.jpg",
      "https://media.cntraveler.com/photos/53da60a46dec627b149e66f4/master/pass/hilton-moorea-lagoon-resort-spa-moorea-french-poly--110160-1.jpg",
      "https://upload.wikimedia.org/wikipedia/commons/0/00/Liz_Murray_Photography_-_Isle_of_Wight_Festival_2014_-_Big_Wheel_View_09_main_stage.jpg",
      "https://i.pinimg.com/originals/36/7c/03/367c03a9121d2713023290544a92149f.jpg",
      "https://cdn.sallysbakingaddiction.com/wp-content/uploads/2013/07/salted-caramel-apple-pie-recipe-7.jpg"
    ];
    CardController controller;
    return SizedBox(
        width: SizeConfig.screenWidth,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(25)),
          child: new Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              child: new TinderSwapCard(
                swipeUp: true,
                swipeDown: true,
                orientation: AmassOrientation.BOTTOM,
                totalNum: welcomeImages.length,
                stackNum: 3,
                swipeEdge: 4.0,
                maxWidth: MediaQuery.of(context).size.width * 0.9,
                maxHeight: MediaQuery.of(context).size.width * 0.9,
                minWidth: MediaQuery.of(context).size.width * 0.8,
                minHeight: MediaQuery.of(context).size.width * 0.8,
                cardBuilder: (context, index) => Card(
                  child: Image.network('${welcomeImages[index]}'),
                ),
                cardController: controller = CardController(),
                swipeUpdateCallback:
                    (DragUpdateDetails details, Alignment align) {
                  /// Get swiping card's alignment
                  if (align.x < 0) {
                    //Card is LEFT swiping
                  } else if (align.x > 0) {
                    //Card is RIGHT swiping
                  }
                },
                swipeCompleteCallback:
                    (CardSwipeOrientation orientation, int index) {
                  /// Get orientation & index of swiped card!
                },
              ),
            ),
          ),
        ));
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
