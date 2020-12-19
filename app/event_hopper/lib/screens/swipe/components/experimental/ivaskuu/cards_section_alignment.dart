import 'package:EventHopper/utils/constants.dart';
import 'package:EventHopper/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'profile_card_alignment.dart';
import 'package:EventHopper/models/events/Event.dart';
import 'dart:math';
import 'package:EventHopper/utils/system_utils.dart';
import 'package:EventHopper/services/eh-server/api_service.dart';

List<Alignment> cardsAlign = [
  Alignment(0.0, 0.5),
  Alignment(0.0, 0.3),
  Alignment(0.0, 0.0)
];
List<Size> cardsSize = List(7);
bool cardEnd = false;
int cardIndex = 0;

class CardsSectionAlignment extends StatefulWidget {
  final Stream<List<Event>> events;
  CardsSectionAlignment(BuildContext context, this.events) {
    cardsSize[0] = Size(MediaQuery.of(context).size.width * 0.8,
        MediaQuery.of(context).size.height * 0.7);
    cardsSize[1] = Size(MediaQuery.of(context).size.width * 0.7,
        MediaQuery.of(context).size.height * 0.65);
    cardsSize[2] = Size(MediaQuery.of(context).size.width * 0.6,
        MediaQuery.of(context).size.height * 0.64);
  }

  @override
  _CardsSectionState createState() => _CardsSectionState();
}

class _CardsSectionState extends State<CardsSectionAlignment>
    with SingleTickerProviderStateMixin {
  int cardsCounter;

  List<ProfileCardAlignment> cards = List();
  AnimationController _controller;

  final Alignment defaultFrontCardAlign = Alignment(0.0, 0.0);
  Alignment frontCardAlign;
  double frontCardRot = 0.0;
  bool loadingCards = false;

  @override
  void initState() {
    super.initState();
    cardIndex = 0;
    cardEnd = false;
    cardsCounter = 3;

    frontCardAlign = cardsAlign[2];

    // Init the animation controller
    _controller =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    _controller.addListener(() => setState(() {}));
    _controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) changeCardsOrder();
    });
    loadingCards = true;
    parseEventStream(widget.events);

    // loadingCards = false;
  }

  parseEventStream(Stream<List<Event>> stream) async {
    await for (List<Event> eventList in widget.events) {
      for (Event event in eventList) {
        ++cardsCounter;
        cards.add(ProfileCardAlignment(cardsCounter, event));
      }
    }
    loadingCards = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return loadingCards
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: getProportionateScreenHeight(600),
                child: SpinKitRotatingCircle(
                  // itemBuilder: (BuildContext context, int index){
                  //   loadingCards ?
                  // },
                  color: kTextColor,
                  size: 50.0,
                ),
              ),
            ],
          )
        : Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                backCard(),
                middleCard(),
                frontCard(),

                // Prevent swiping if the cards are animating
                _controller.status != AnimationStatus.forward
                    ? SizedBox(
                        child: GestureDetector(
                        // While dragging the first card
                        onPanUpdate: (DragUpdateDetails details) {
                          // Add what the user swiped in the last frame to the alignment of the card
                          setState(() {
                            // 20 is the "speed" at which moves the card
                            frontCardAlign = Alignment(
                                frontCardAlign.x +
                                    20 *
                                        details.delta.dx /
                                        MediaQuery.of(context).size.width,
                                frontCardAlign.y +
                                    20 *
                                        details.delta.dy /
                                        MediaQuery.of(context).size.height);

                            // print(frontCardAlign);

                            frontCardRot =
                                frontCardAlign.x * 3; // * rotation speed;
                          });
                        },
                        onPanStart: (_) {
                          // Add Feedback swoosh
                        },
                        // When releasing the first card
                        onPanEnd: (_) {
                          // If the front card was swiped far enough to count as swiped
                          if ((frontCardAlign.x > 5.0 ||
                                  frontCardAlign.x < -5.0 &&
                                      frontCardAlign.y > -5) ||
                              frontCardAlign.y < -5) {
                            //Right Swipe
                            if (frontCardAlign.x > 5 && frontCardAlign.y > -5) {
                              print('RIGHT SWIPE');
                              apiService.swipeEntry(
                                  direction: "event_right",
                                  eventId: "event_id_right_1");
                            }

                            //Left Swipe
                            if (frontCardAlign.x < -5 &&
                                frontCardAlign.y > -5) {
                              print('LEFT SWIPE');
                              apiService.swipeEntry(
                                  direction: "event_left",
                                  eventId: "event_id_left_1");
                            }

                            //Up Swipe
                            if (frontCardAlign.y < -5) {
                              print('UP SWIPE');
                              apiService.swipeEntry(
                                  direction: "event_up",
                                  eventId: "event_id_up_2");
                            }
                            SystemUtils.vibrate();
                            animateCards();
                          } else {
                            // Return to the initial rotation and alignment
                            setState(() {
                              frontCardAlign = defaultFrontCardAlign;
                              frontCardRot = 0.0;
                            });
                          }
                        },
                      ))
                    : Container(),
              ],
            ),
          );
  }

  Widget backCard() {
    return Align(
      alignment: _controller.status == AnimationStatus.forward
          ? CardsAnimation.backCardAlignmentAnim(_controller).value
          : cardsAlign[0],
      child: SizedBox.fromSize(
          size: _controller.status == AnimationStatus.forward
              ? CardsAnimation.backCardSizeAnim(_controller).value
              : cardsSize[2],
          child: cardIndex < cards.length - 2
              ? cards[cardIndex + 2]
              : Container()),
    );
  }

  Widget middleCard() {
    return Align(
      alignment: _controller.status == AnimationStatus.forward
          ? CardsAnimation.middleCardAlignmentAnim(_controller).value
          : cardsAlign[1],
      child: SizedBox.fromSize(
          size: _controller.status == AnimationStatus.forward
              ? CardsAnimation.middleCardSizeAnim(_controller).value
              : cardsSize[1],
          child: cardIndex < cards.length - 1
              ? cards[cardIndex + 1]
              : Container()),
    );
  }

  Widget frontCard() {
    if (!cardEnd) {
      return Align(
          alignment: _controller.status == AnimationStatus.forward
              ? CardsAnimation.frontCardDisappearAlignmentAnim(
                      _controller, frontCardAlign)
                  .value
              : frontCardAlign,
          child: Transform.rotate(
            angle: (pi / 180.0) * frontCardRot,
            child:
                SizedBox.fromSize(size: cardsSize[0], child: cards[cardIndex]),
          ));
    } else {
      return SwipeEndMessage();
    }
  }

  void changeCardsOrder() {
    setState(() {
      // Swap cards (back card becomes the middle card; middle card becomes the front card, front card becomes a  bottom card)
      // var temp = cards[0];
      if (!cardEnd) {
        // cards[0] = cards[1];
        // cards[1] = cards[2];
        // // cards[2] = temp;

        // cards[2] = cards[(cardsCounter) % cards.length];
        // cardsCounter++;

        cardIndex++;

        if (cardIndex == cards.length) {
          // cardsCounter = 0;
          endCards();
          return;
        }

        frontCardAlign = defaultFrontCardAlign;
        frontCardRot = 0.0;
      }
    });
  }

  void endCards() {
    cardEnd = true;
  }

  void animateCards() {
    _controller.stop();
    _controller.value = 0.0;
    _controller.forward();
  }
}

class SwipeEndMessage extends StatelessWidget {
  const SwipeEndMessage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: getProportionateScreenHeight(100)),
            SvgPicture.asset(
              'assets/images/donepurp.svg',
              height: getProportionateScreenHeight(120),
            ),
            VerticalSpacing(),
            Container(
                width: getProportionateScreenWidth(300),
                child: Column(
                  children: [
                    Text(
                      "FINISHED",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 23,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      "Check back later for more!",
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

class CardsAnimation {
  static Animation<Alignment> backCardAlignmentAnim(
      AnimationController parent) {
    return AlignmentTween(begin: cardsAlign[0], end: cardsAlign[1]).animate(
        CurvedAnimation(
            parent: parent, curve: Interval(0.4, 0.7, curve: Curves.easeIn)));
  }

  static Animation<Size> backCardSizeAnim(AnimationController parent) {
    return SizeTween(begin: cardsSize[2], end: cardsSize[1]).animate(
        CurvedAnimation(
            parent: parent, curve: Interval(0.4, 0.7, curve: Curves.easeIn)));
  }

  static Animation<Alignment> middleCardAlignmentAnim(
      AnimationController parent) {
    return AlignmentTween(begin: cardsAlign[1], end: cardsAlign[2]).animate(
        CurvedAnimation(
            parent: parent, curve: Interval(0.2, 0.5, curve: Curves.easeIn)));
  }

  static Animation<Size> middleCardSizeAnim(AnimationController parent) {
    return SizeTween(begin: cardsSize[2], end: cardsSize[0]).animate(
        CurvedAnimation(
            parent: parent, curve: Interval(0.2, 0.7, curve: Curves.easeIn)));
  }

  static Animation<Alignment> frontCardDisappearAlignmentAnim(
      AnimationController parent, Alignment beginAlign) {
    return AlignmentTween(
            begin: beginAlign,
            end: Alignment(
                beginAlign.x > 3 && beginAlign.y > -3
                    ? beginAlign.x + 20.0
                    : beginAlign.x < -3 && beginAlign.y > -3
                        ? beginAlign.x - 20.0
                        : 0.0,
                beginAlign.y < 0
                    ? beginAlign.y - 30
                    : 0.0) // Has swiped to the left or right or up?
            )
        .animate(CurvedAnimation(
            parent: parent, curve: Interval(0.0, 0.5, curve: Curves.easeIn)));
  }
}
