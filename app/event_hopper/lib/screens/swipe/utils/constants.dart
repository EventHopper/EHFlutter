import 'package:flutter/material.dart';

/// Strings & Fonts

const String kIndicatorLeftMessage = 'nah';
const String kIndicatorRightMessage = 'maybe';
const String kIndicatorUpMessage = 'go!';

/// Dimensions & Proportions

const int kNumberOfCards = 3;

const List<Alignment> kCardsAlign = [
  Alignment(0.0, 0.5),
  Alignment(0.0, 0.3),
  Alignment(0.0, 0.0)
];

const Alignment kDefaultBackCardAlign = Alignment(0.0, 0.5);
const Alignment kDefaultMiddleCardAlign = Alignment(0.0, 0.3);
const Alignment kDefaultFrontCardAlign = Alignment(0.0, 0.0);

const double kInitialFrontCardRotation = 0.0;
const int kAnimationDurationMs = 100;

const List<double> kFrontCardSizeRatio = [0.8, 0.7];
const List<double> kMiddleCardSizeRatio = [0.7, 0.65];
const List<double> kBackCardSizeRatio = [0.6, 0.64];

const double kInputScreenHeight = 700;
const double kDefaultSwipePadding = 12.0;
const double kSpinKitSize = 50.0;

const double kIndicatorLeftOffsetDivisorX = 1;
const double kIndicatorRightOffsetDivisorX = 2.5;
const double kIndicatorUpOffsetDivisorX = 9.0;
const double kIndicatorUpOffsetDivisorY = 5;

const double kIndicatorRadiusSpeed = 80;

/// Animations

const String kEventPageHeroTag = 'event-card';
const String kLeftSwipeDirectionLabel = 'event_left';
const String kRightSwipeDirectionLabel = 'event_right';
const String kUpSwipeDirectionLabel = 'event_up';

const double kControllerInitialValue = 0.0;
const double kCardMovementSpeed = 20;
const double kCardRotationSpeed = 3;

const double kLeftSwipeThreshold = -3.5;
const double kRightSwipeThreshold = 3.5;
const double kUpSwipeThreshold = -3.5;
const double kCardOpacity = 0.9;

const double kIndicatorLeftThreshold = -1.0;
const double kIndicatorRightThreshold = 1.0;
const double kIndicatorUpThreshold = -1.0;
const double kIndicatorOpacityFactor = 10;

const double kLeftSwipeIncrement = 20.0;
const double kRightSwipeIncrement = 20.0;
const double kUpSwipeIncrement = 30;

const double kLeftSwipeRotation = -20.0;
const double kRightSwipeRotation = 20.0;
const double kUpSwipeRotation = 0.0;

const Alignment kLeftSwipeAlign = Alignment(-4.0, 0.0);
const Alignment kRightSwipeAlign = Alignment(4.0, 0.0);
const Alignment kUpSwipeAlign = Alignment(0.0, -5.0);

const Curve kBackCardAlignCurve = Interval(0.4, 0.7, curve: Curves.easeIn);
const Curve kBackCardSizeCurve = Interval(0.4, 0.7, curve: Curves.easeIn);
const Curve kMiddleCardAlignCurve = Interval(0.2, 0.5, curve: Curves.easeIn);
const Curve kMiddleCardSizeCurve = Interval(0.2, 0.7, curve: Curves.easeIn);
const Curve kFrontCardDisappearCurve = Interval(0.0, 0.5, curve: Curves.easeIn);

/// Colors

const Color kIndicatorLeftColor = Colors.red;
const Color kIndicatorRightColor = Colors.green;
const Color kIndicatorUpColor = Colors.blue;
const Color kIndicatorTextColor = Colors.white;

/// Strings

const String kAddToCalendar = "Add To Calendar";
const String kAddToCalendarDescription =
    "Would you like to add this event to your calendar ? ";

/// Text
const TextStyle kTextStyle =
    TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600);

const Text kTitleText =
    Text(kAddToCalendar, textAlign: TextAlign.center, style: kTextStyle);
