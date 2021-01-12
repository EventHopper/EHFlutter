import 'package:EventHopper/screens/event_page/event_page.dart';
import 'package:EventHopper/services/state-management/session_manager.dart';
import 'package:EventHopper/utils/constants.dart';
import 'package:EventHopper/utils/screen_navigator.dart';
import 'package:EventHopper/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:EventHopper/screens/swipe/utils/components/swipe_end_message.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'swipe_indicator_painter.dart';
import 'swipe_card.dart';
import 'package:EventHopper/models/events/Event.dart';
import 'dart:math';
import 'package:EventHopper/utils/system_utils.dart';
import 'package:EventHopper/services/eh-server/api_service.dart';
import 'package:EventHopper/screens/swipe/utils/constants.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

List<Size> cardsSize = List(kNumberOfCards);

bool cardEnd = false;
int cardIndex = 0;

Alignment endAlignmentPuppet;
double frontCardRot = kInitialFrontCardRotation;
Size frontCardSize;
Size middleCardSize;
Size backCardSize;

class SwipeSequenceSection extends StatefulWidget {
  final Stream<List<Event>> events;
  SwipeSequenceSection(BuildContext context, this.events) {
    frontCardSize = Size(
        MediaQuery.of(context).size.width * kFrontCardSizeRatio[0],
        MediaQuery.of(context).size.height * kFrontCardSizeRatio[1]);

    middleCardSize = Size(
        MediaQuery.of(context).size.width * kMiddleCardSizeRatio[0],
        MediaQuery.of(context).size.height * kMiddleCardSizeRatio[1]);

    backCardSize = Size(
        MediaQuery.of(context).size.width * kBackCardSizeRatio[0],
        MediaQuery.of(context).size.height * kBackCardSizeRatio[1]);
  }

  @override
  _CardsSectionState createState() => _CardsSectionState();
}

class _CardsSectionState extends State<SwipeSequenceSection>
    with SingleTickerProviderStateMixin {
  int cardsCounter;

  List<SwipeCard> cards = List();
  AnimationController _controller;

  Alignment frontCardAlign;

  bool loadingCards = false;

  @override
  void initState() {
    super.initState();
    cardIndex = 0;
    cardEnd = false;
    cardsCounter = 0;

    frontCardAlign = kDefaultFrontCardAlign;

    // Init the animation controller
    _controller = AnimationController(
        duration: Duration(milliseconds: kAnimationDurationMs), vsync: this);
    _controller.addListener(() => setState(() {}));
    _controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        changeCardsOrder();
        endAlignmentPuppet = null;
        frontCardRot = kInitialFrontCardRotation;
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
        cards.add(SwipeCard(cardsCounter, event));
      }
    }
    loadingCards = false;
    cards[cardIndex]
      ..heroTag = kEventPageHeroTag; // Adds hero tag to first card
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return loadingCards
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: getProportionateScreenHeight(kInputScreenHeight),
                width: MediaQuery.of(context).size.width,
                child: SpinKitRotatingCircle(
                  color: kTextColor,
                  size: kSpinKitSize,
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
                            // kCardMovementSpeed is the "speed" at which moves the card
                            frontCardAlign = Alignment(
                                frontCardAlign.x +
                                    kCardMovementSpeed *
                                        details.delta.dx /
                                        MediaQuery.of(context).size.width,
                                frontCardAlign.y +
                                    kCardMovementSpeed *
                                        details.delta.dy /
                                        MediaQuery.of(context).size.height);
                            // Uncomment for debug purposes
                            // print(frontCardAlign);

                            frontCardRot = frontCardAlign.x *
                                kCardRotationSpeed; // * rotation speed;
                          });
                        },
                        onPanStart: (_) {
                          // Add Feedback swoosh
                        },
                        // When releasing the first card
                        onPanEnd: (_) {
                          // If the front card was swiped far enough to count as swiped
                          if ((frontCardAlign.x > kRightSwipeThreshold ||
                                  frontCardAlign.x < kLeftSwipeThreshold &&
                                      frontCardAlign.y > kUpSwipeThreshold) ||
                              frontCardAlign.y < kUpSwipeThreshold) {
                            //Right Swipe
                            if (frontCardAlign.x > kRightSwipeThreshold &&
                                frontCardAlign.y > kUpSwipeThreshold) {
                              print('RIGHT SWIPE');
                              apiService.swipeEntry(
                                  direction: "event_right",
                                  eventId: "${cards[cardIndex].getEvent().id}");
                              addEventToLocalList(
                                  context,
                                  kRightSwipeDirectionLabel,
                                  cards[cardIndex].getEvent());
                            }

                            //Left Swipe
                            if (frontCardAlign.x < kLeftSwipeThreshold &&
                                frontCardAlign.y > kUpSwipeThreshold) {
                              print('LEFT SWIPE');
                              apiService.swipeEntry(
                                  direction: "event_left",
                                  eventId: "${cards[cardIndex].getEvent().id}");
                              addEventToLocalList(
                                  context,
                                  kLeftSwipeDirectionLabel,
                                  cards[cardIndex].getEvent());
                            }

                            //Up Swipe
                            if (frontCardAlign.y < kUpSwipeThreshold) {
                              print('UP SWIPE');
                              showDialog(
                                  context: context,
                                  builder: (_) => getCalendarDialog());
                              apiService.swipeEntry(
                                  direction: "event_up",
                                  eventId: "${cards[cardIndex].getEvent().id}");
                              addEventToLocalList(
                                  context,
                                  kUpSwipeDirectionLabel,
                                  cards[cardIndex].getEvent());
                            }

                            animateCards();
                          } else {
                            // Return to the initial rotation and alignment
                            setState(() {
                              frontCardAlign = kDefaultFrontCardAlign;
                              frontCardRot = kInitialFrontCardRotation;
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
          : kDefaultBackCardAlign,
      child: SizedBox.fromSize(
          size: _controller.status == AnimationStatus.forward
              ? CardsAnimation.backCardSizeAnim(_controller).value
              : backCardSize,
          child: cardIndex < cards.length - 2
              ? cards[cardIndex + 2]
              : Container()),
    );
  }

  Widget middleCard() {
    return Align(
      alignment: _controller.status == AnimationStatus.forward
          ? CardsAnimation.middleCardAlignmentAnim(_controller).value
          : kDefaultMiddleCardAlign,
      child: SizedBox.fromSize(
          size: _controller.status == AnimationStatus.forward
              ? CardsAnimation.middleCardSizeAnim(_controller).value
              : middleCardSize,
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
              opacity: kCardOpacity,
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
      return Align(
        alignment: _controller.status == AnimationStatus.forward
            ? CardsAnimation.frontCardDisappearAlignmentAnim(
                    _controller, frontCardAlign,
                    endAlign: endAlignmentPuppet)
                .value
            : frontCardAlign,
        child: Transform.rotate(
          angle: (pi / 180.0) * frontCardRot,
          child: SizedBox.fromSize(
            size: frontCardSize,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  ScreenNavigator.widget(
                      context, EventPage(event: cards[cardIndex].getEvent()));
                },
                child: cards[cardIndex],
              ),
            ),
          ),
        ),
      );
    } else {
      frontCardAlign = kDefaultFrontCardAlign;
      return SwipeEndMessage();
    }
  }

  void changeCardsOrder() {
    setState(() {
      if (!cardEnd) {
        cardIndex++;
        frontCardAlign = kDefaultFrontCardAlign;
        frontCardRot = kInitialFrontCardRotation;
        if (cardIndex >= cards.length) {
          endCards();
        } else {
          cards[cardIndex]
            ..heroTag = kEventPageHeroTag; // Adds hero tag to subsequent cards
        }
      }
    });
  }

  void endCards() {
    frontCardRot = kInitialFrontCardRotation;
    cardEnd = true;
  }

  void animateCards() {
    SystemUtils.vibrate();

    _controller.stop();
    _controller.value = kControllerInitialValue;
    _controller.forward();
  }

  NetworkGiffyDialog getCalendarDialog() {
    return NetworkGiffyDialog(
      image: Image.network(
        cards[cardIndex].getEvent().image,
        fit: BoxFit.cover,
      ),
      entryAnimation: EntryAnimation.BOTTOM,
      title: kTitleText,
      description: Text(
        kAddToCalendarDescription,
        textAlign: TextAlign.center,
      ),
      onOkButtonPressed: () {
        Navigator.of(context).pop();
        //TODO: Add to calendar
      },
    );
  }

  Widget buttonsRow() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: "swipe-discard",
            onPressed: () async {
              if (cardEnd) return;
              print('LEFT SWIPE');
              endAlignmentPuppet = kLeftSwipeAlign;
              frontCardRot = kLeftSwipeRotation;
              apiService.swipeEntry(
                  direction: kLeftSwipeDirectionLabel,
                  eventId: "${cards[cardIndex].getEvent().id}");
              addEventToLocalList(context, kLeftSwipeDirectionLabel,
                  cards[cardIndex].getEvent());
              animateCards();
            },
            mini: true,
            backgroundColor: Colors.white,
            child: Icon(Icons.close, color: kIndicatorLeftColor),
          ),
          Padding(padding: EdgeInsets.only(right: kDefaultSwipePadding)),
          FloatingActionButton(
            heroTag: "swipe-accept",
            onPressed: () async {
              if (cardEnd) return;
              print('UP SWIPE');
              endAlignmentPuppet = kUpSwipeAlign;
              frontCardRot = kUpSwipeRotation;
              apiService.swipeEntry(
                  direction: kUpSwipeDirectionLabel,
                  eventId: "${cards[cardIndex].getEvent().id}");
              addEventToLocalList(
                  context, kUpSwipeDirectionLabel, cards[cardIndex].getEvent());
              animateCards();
              showDialog(context: context, builder: (_) => getCalendarDialog());
            },
            backgroundColor: Colors.white,
            child: Icon(Icons.favorite, color: kIndicatorUpColor),
          ),
          Padding(padding: EdgeInsets.only(right: kDefaultSwipePadding)),
          FloatingActionButton(
            heroTag: "swipe-maybe",
            mini: true,
            onPressed: () async {
              if (cardEnd) return;
              print('RIGHT SWIPE');
              endAlignmentPuppet = kRightSwipeAlign;
              frontCardRot = kRightSwipeRotation;
              apiService.swipeEntry(
                  direction: kRightSwipeDirectionLabel,
                  eventId: "${cards[cardIndex].getEvent().id}");
              addEventToLocalList(context, kRightSwipeDirectionLabel,
                  cards[cardIndex].getEvent());
              animateCards();
            },
            backgroundColor: Colors.white,
            child: Icon(Icons.star, color: kIndicatorRightColor),
          ),
        ],
      ),
    );
  }
}

class CardsAnimation {
  static Animation<Alignment> backCardAlignmentAnim(
      AnimationController parent) {
    return AlignmentTween(
            begin: kDefaultBackCardAlign, end: kDefaultMiddleCardAlign)
        .animate(CurvedAnimation(parent: parent, curve: kBackCardAlignCurve));
  }

  static Animation<Size> backCardSizeAnim(AnimationController parent) {
    return SizeTween(begin: backCardSize, end: middleCardSize)
        .animate(CurvedAnimation(parent: parent, curve: kBackCardSizeCurve));
  }

  static Animation<Alignment> middleCardAlignmentAnim(
      AnimationController parent) {
    return AlignmentTween(begin: kDefaultMiddleCardAlign, end: kCardsAlign[2])
        .animate(CurvedAnimation(parent: parent, curve: kMiddleCardAlignCurve));
  }

  static Animation<Size> middleCardSizeAnim(AnimationController parent) {
    return SizeTween(begin: backCardSize, end: frontCardSize)
        .animate(CurvedAnimation(parent: parent, curve: kMiddleCardSizeCurve));
  }

  static Animation<Alignment> frontCardDisappearAlignmentAnim(
      AnimationController parent, Alignment beginAlign,
      {Alignment endAlign}) {
    return AlignmentTween(
            begin: beginAlign,
            end: endAlign != null
                ? endAlign
                : Alignment(
                    beginAlign.x > kRightSwipeThreshold &&
                            beginAlign.y > kLeftSwipeThreshold
                        ? beginAlign.x + kRightSwipeIncrement
                        : beginAlign.x < kLeftSwipeThreshold &&
                                beginAlign.y > kUpSwipeThreshold
                            ? beginAlign.x - kLeftSwipeIncrement
                            : kDefaultFrontCardAlign.x,
                    beginAlign.y < kDefaultFrontCardAlign.y
                        ? beginAlign.y - kUpSwipeIncrement
                        : kDefaultFrontCardAlign
                            .y) // Has swiped to the left or right or up?
            )
        .animate(
            CurvedAnimation(parent: parent, curve: kFrontCardDisappearCurve));
  }
}

void addEventToLocalList(
    BuildContext context, String direction, Event event) async {
  switch (direction) {
    case kLeftSwipeDirectionLabel:
      if (Provider.of<SessionManager>(context, listen: false)
          .addEventLeft(event)) {
        Provider.of<SessionManager>(context, listen: false)
            .incrementEventLeftCount();
      }
      break;
    case kRightSwipeDirectionLabel:
      if (Provider.of<SessionManager>(context, listen: false)
          .addEventRight(event)) {
        Provider.of<SessionManager>(context, listen: false)
            .incrementEventRightCount();
        Provider.of<SessionManager>(context, listen: false)
            .incrementEventTotalCount();
      }
      break;
    case kUpSwipeDirectionLabel:
      if (Provider.of<SessionManager>(context, listen: false)
          .addEventUp(event)) {
        Provider.of<SessionManager>(context, listen: false)
            .incrementEventUpCount();
        Provider.of<SessionManager>(context, listen: false)
            .incrementEventTotalCount();
        break;
      }
  }
}
