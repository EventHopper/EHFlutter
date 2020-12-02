import 'package:EventHopper/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'profile_card_alignment.dart';
import 'package:EventHopper/models/events/Event.dart';
import 'dart:math';

List<Alignment> cardsAlign = [
  Alignment(0.0, 3.0),
  Alignment(0.0, 0.8),
  Alignment(0.0, 0.0)
];
List<Size> cardsSize = List(7);
bool cardEnd = false;

class CardsSectionAlignment extends StatefulWidget {
  final Stream<List<Event>> events;
  CardsSectionAlignment(BuildContext context, this.events) {
    cardsSize[0] = Size(MediaQuery.of(context).size.width * 0.8,
        MediaQuery.of(context).size.height * 1);
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

  @override
  void initState() {
    super.initState();

    // Init cards
    widget.events.forEach((eventList) {
      for (Event event in eventList) {
        cards.add(ProfileCardAlignment(cardsCounter, event));
      }
    });

    cardsCounter = 3;

    frontCardAlign = cardsAlign[2];

    // Init the animation controller
    _controller =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    _controller.addListener(() => setState(() {}));
    _controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) changeCardsOrder();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Stack(
      children: <Widget>[
        backCard(),
        middleCard(),
        frontCard(),

        // Prevent swiping if the cards are animating
        _controller.status != AnimationStatus.forward
            ? SizedBox.expand(
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
                            40 *
                                details.delta.dy /
                                MediaQuery.of(context).size.height);

                    frontCardRot = frontCardAlign.x; // * rotation speed;
                  });
                },
                onPanStart: (_) {
                  // Add Feedback swoosh
                },
                // When releasing the first card
                onPanEnd: (_) {
                  // If the front card was swiped far enough to count as swiped
                  if (frontCardAlign.x > 3.0 || frontCardAlign.x < -3.0) {
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
    ));
  }

  Widget backCard() {
    if (!cardEnd) {
      return Align(
        alignment: _controller.status == AnimationStatus.forward
            ? CardsAnimation.backCardAlignmentAnim(_controller).value
            : cardsAlign[0],
        child: SizedBox.fromSize(
            size: _controller.status == AnimationStatus.forward
                ? CardsAnimation.backCardSizeAnim(_controller).value
                : cardsSize[2],
            child: cards[2]),
      );
    } else {
      return SwipeEndMessage();
    }
  }

  Widget middleCard() {
    if (!cardEnd) {
      return Align(
        alignment: _controller.status == AnimationStatus.forward
            ? CardsAnimation.middleCardAlignmentAnim(_controller).value
            : cardsAlign[1],
        child: SizedBox.fromSize(
            size: _controller.status == AnimationStatus.forward
                ? CardsAnimation.middleCardSizeAnim(_controller).value
                : cardsSize[1],
            child: cards[1]),
      );
    } else {
      return SwipeEndMessage();
    }
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
            child: SizedBox.fromSize(size: cardsSize[0], child: cards[0]),
          ));
    } else {
      return Container();
    }
  }

  void changeCardsOrder() {
    setState(() {
      // Swap cards (back card becomes the middle card; middle card becomes the front card, front card becomes a  bottom card)
      // var temp = cards[0];
      if (!cardEnd) {
        cards[0] = cards[1];
        cards[1] = cards[2];
        // cards[2] = temp;

        cards[2] = cards[(cardsCounter) % cards.length];
        cardsCounter++;

        if (cardsCounter == cards.length + 3) {
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
                beginAlign.x > 0 ? beginAlign.x + 30.0 : beginAlign.x - 30.0,
                0.0) // Has swiped to the left or right?
            )
        .animate(CurvedAnimation(
            parent: parent, curve: Interval(0.0, 0.5, curve: Curves.easeIn)));
  }
}
