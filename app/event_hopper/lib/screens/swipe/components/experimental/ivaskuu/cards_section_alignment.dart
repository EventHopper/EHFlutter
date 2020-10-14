import 'package:EventHopper/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'profile_card_alignment.dart';
import 'dart:math';

List<String> imageUrls = [
  'https://images.unsplash.com/photo-1576083895015-17223a61998e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  'https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80',
  'https://images.unsplash.com/photo-1527529482837-4698179dc6ce?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80',
  'https://images.unsplash.com/photo-1496337589254-7e19d01cec44?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80',
  'https://images.unsplash.com/photo-1601738178459-640e986ee0d9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1057&q=80',
  'https://images.unsplash.com/photo-1601993396003-6cbec70ce171?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  'https://images.unsplash.com/photo-1601993396046-7485bbf4ac16?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  'https://images.unsplash.com/photo-1601994972637-0ea711efa322?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=650&q=80',
  'https://images.unsplash.com/photo-1601987932091-135cac222040?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=687&q=80',
  'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=662&q=80',
  'https://images.unsplash.com/photo-1579487685737-e435a87b2518?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  'https://images.unsplash.com/photo-1501116518234-f32f28802bd1?ixlib=rb-1.2.1&auto=format&fit=crop&w=948&q=80',
  'https://images.unsplash.com/photo-1583807563351-25a3e8242a67?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  'https://images.unsplash.com/photo-1522010675502-c7b3888985f6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  'https://images.unsplash.com/photo-1568042469170-e5cff7f4d64f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  'https://images.unsplash.com/photo-1589050820342-d666e6116a45?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1053&q=80',
  'https://images.unsplash.com/photo-1593642634443-44adaa06623a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=925&q=80',
  'https://images.unsplash.com/photo-1562490654-131366a15276?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80',
  'https://images.unsplash.com/photo-1563452965085-2e77e5bf2607?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  'https://images.unsplash.com/photo-1525183995014-bd94c0750cd5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=675&q=80',
  'https://images.unsplash.com/photo-1534570122623-99e8378a9aa7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80',
  'https://images.unsplash.com/photo-1504681869696-d977211a5f4c?ixlib=rb-1.2.1&auto=format&fit=crop&w=581&q=80',
];

List<Alignment> cardsAlign = [
  Alignment(0.0, 3.0),
  Alignment(0.0, 0.8),
  Alignment(0.0, 0.0)
];
List<Size> cardsSize = List(7);
bool cardEnd = false;

class CardsSectionAlignment extends StatefulWidget {
  CardsSectionAlignment(BuildContext context) {
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
    for (cardsCounter = 0;
        cardsCounter < imageUrls.length - 1;
        cardsCounter++) {
      cards.add(ProfileCardAlignment(cardsCounter, imageUrls[cardsCounter]));
    }
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

        cards[2] = ProfileCardAlignment(
            cardsCounter, imageUrls[(cardsCounter) % imageUrls.length]);
        cardsCounter++;

        if (cardsCounter == imageUrls.length + 3) {
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
