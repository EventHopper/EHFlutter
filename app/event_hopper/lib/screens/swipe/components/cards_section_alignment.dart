import 'package:EventHopper/utils/constants.dart';
import 'package:EventHopper/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile_card_alignment.dart';
import 'package:EventHopper/models/events/Event.dart';
import 'dart:math';
import 'package:EventHopper/utils/system_utils.dart';
import 'package:EventHopper/services/eh-server/api_service.dart';
import 'dart:ui' as ui;

List<Alignment> cardsAlign = [
  Alignment(0.0, 0.5),
  Alignment(0.0, 0.3),
  Alignment(0.0, 0.0)
];
List<Size> cardsSize = List(7);
bool cardEnd = false;
int cardIndex = 0;

Alignment endAlignmentPuppet;
double frontCardRot = 0.0;

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

  bool loadingCards = false;

  @override
  void initState() {
    super.initState();
    cardIndex = 0;
    cardEnd = false;
    cardsCounter = 0;

    frontCardAlign = cardsAlign[2];

    // Init the animation controller
    _controller =
        AnimationController(duration: Duration(milliseconds: 100), vsync: this);
    _controller.addListener(() => setState(() {}));
    _controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        changeCardsOrder();
        endAlignmentPuppet = null;
        frontCardRot = 0;
      }
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
                height: getProportionateScreenHeight(700),
                width: MediaQuery.of(context).size.width,
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
                swipeIndicator(),
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
                                  eventId: "${cards[cardIndex].getEvent().id}");
                            }

                            //Left Swipe
                            if (frontCardAlign.x < -5 &&
                                frontCardAlign.y > -5) {
                              print('LEFT SWIPE');
                              apiService.swipeEntry(
                                  direction: "event_left",
                                  eventId: "${cards[cardIndex].getEvent().id}");
                            }

                            //Up Swipe
                            if (frontCardAlign.y < -5) {
                              print('UP SWIPE');
                              apiService.swipeEntry(
                                  direction: "event_up",
                                  eventId: "${cards[cardIndex].getEvent().id}");
                            }

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
                Positioned.fill(
                  child: Align(
                      child: buttonsRow(), alignment: Alignment.bottomCenter),
                )
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

  Widget swipeIndicator() {
    return !cardEnd
        ? GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: Opacity(
              opacity: 0.9,
              child: CustomPaint(
                size: MediaQuery.of(context).size,
                painter:
                    SwipeIndicatorPainter(frontCardAlign.x, frontCardAlign.y),
              ),
            ),
          )
        : Container();
  }

  Widget frontCard() {
    if (!cardEnd) {
      return InkWell(
        onTap: () {
          cards[cardIndex].getEvent();
        },
        child: Align(
            alignment: _controller.status == AnimationStatus.forward
                ? CardsAnimation.frontCardDisappearAlignmentAnim(
                        _controller, frontCardAlign,
                        endAlign: endAlignmentPuppet)
                    .value
                : frontCardAlign,
            child: Transform.rotate(
              angle: (pi / 180.0) * frontCardRot,
              child: SizedBox.fromSize(
                  size: cardsSize[0], child: cards[cardIndex]),
            )),
      );
    } else {
      return SwipeEndMessage();
    }
  }

  void changeCardsOrder() {
    setState(() {
      if (!cardEnd) {
        cardIndex++;

        if (cardIndex == cards.length) {
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
    SystemUtils.vibrate();
    _controller.stop();
    _controller.value = 0.0;
    _controller.forward();
  }

  Widget buttonsRow() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton(
            heroTag: "swipe-discard",
            onPressed: () {
              print('LEFT SWIPE');
              endAlignmentPuppet = new Alignment(-4.0, 0.0);
              frontCardRot = -20;
              apiService.swipeEntry(
                  direction: "event_left",
                  eventId: "${cards[cardIndex].getEvent().id}");
              animateCards();
            },
            mini: true,
            backgroundColor: Colors.white,
            child: Icon(Icons.close, color: Colors.red),
          ),
          Padding(padding: EdgeInsets.only(right: 12.0)),
          FloatingActionButton(
            heroTag: "swipe-accept",
            onPressed: () {
              print('UP SWIPE');
              endAlignmentPuppet = new Alignment(0.0, -5.0);
              apiService.swipeEntry(
                  direction: "event_up",
                  eventId: "${cards[cardIndex].getEvent().id}");

              animateCards();
            },
            backgroundColor: Colors.white,
            child: Icon(Icons.favorite, color: Colors.blue),
          ),
          Padding(padding: EdgeInsets.only(right: 12.0)),
          FloatingActionButton(
            heroTag: "swipe-maybe",
            mini: true,
            onPressed: () {
              print('RIGHT SWIPE');
              endAlignmentPuppet = new Alignment(4.0, 0.0);
              frontCardRot = 20;
              apiService.swipeEntry(
                  direction: "event_right",
                  eventId: "${cards[cardIndex].getEvent().id}");
              animateCards();
            },
            backgroundColor: Colors.white,
            child: Icon(Icons.star, color: Colors.green),
          ),
        ],
      ),
    );
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
      AnimationController parent, Alignment beginAlign,
      {Alignment endAlign}) {
    return AlignmentTween(
            begin: beginAlign,
            end: endAlign != null
                ? endAlign
                : Alignment(
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

class SwipeIndicatorPainter extends CustomPainter {
  final double xDirection;
  final double yDirection;

  Color color;
  int opacityFactor = 10;
  SwipeIndicatorPainter(this.xDirection, this.yDirection);

  @override
  void paint(Canvas canvas, Size size) {
    //  print('($xDirection,$yDirection)');
    /// Circle indicator

    bool isLeft = this.xDirection < -2 && this.yDirection > -3;
    bool isRight = this.xDirection > 2 && this.yDirection > -3;
    bool isUp = this.yDirection < -3;

    this.color = isLeft
        ? Color.fromRGBO(Colors.red.red, Colors.red.green, Colors.red.blue,
            min(this.xDirection.abs() / opacityFactor, 1))
        : isRight
            ? Color.fromRGBO(
                Colors.green.red,
                Colors.green.green,
                Colors.green.blue,
                min(this.xDirection.abs() / opacityFactor, 1))
            : isUp
                ? Color.fromRGBO(
                    Colors.blue.red,
                    Colors.blue.green,
                    Colors.blue.blue,
                    min(this.yDirection.abs() / opacityFactor, 1))
                : Colors.transparent;

    var paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    var path = Path();
    path.addOval(Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: max(xDirection.abs() * 80, yDirection.abs() * 80),
    ));
    canvas.drawPath(path, paint);

    /// Text prompt
    final textStyle = ui.TextStyle(
      color: Color.fromRGBO(
          255,
          255,
          255,
          max(min(this.xDirection.abs() / opacityFactor, 1),
              min(this.yDirection.abs() / opacityFactor, 1))),
      fontSize: 60,
    );
    final paragraphStyle = ui.ParagraphStyle(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.start,
      fontFamily: 'Arial',
      // fontWeight: FontWeight
    );
    final paragraphBuilder = ui.ParagraphBuilder(paragraphStyle)
      ..pushStyle(textStyle)
      ..addText(isLeft
          ? 'nah'
          : isRight
              ? 'maybe'
              : isUp
                  ? 'go!'
                  : '');
    final constraints = ui.ParagraphConstraints(width: 300);
    final paragraph = paragraphBuilder.build();
    paragraph.layout(constraints);
    final offset = Offset(
      size.width / 2 -
          (isLeft
              ? 0
              : isRight
                  ? size.width / 2.5
                  : isUp
                      ? size.width / 9
                      : 0),
      size.height / 2 + (isUp ? size.width / 5 : 0),
    );
    canvas.drawParagraph(paragraph, offset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
