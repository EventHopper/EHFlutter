import 'package:EventHopper/screens/swipe/utils/constants.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui' as ui;

class SwipeIndicatorPainter extends CustomPainter {
  final double xDirection;
  final double yDirection;

  Color color;

  SwipeIndicatorPainter(this.xDirection, this.yDirection);

  @override
  void paint(Canvas canvas, Size size) {
    //  print('($xDirection,$yDirection)');
    /// Circle indicator

    bool isLeft = this.xDirection < kIndicatorLeftThreshold &&
        this.yDirection > kIndicatorUpThreshold;
    bool isRight = this.xDirection > kIndicatorRightThreshold &&
        this.yDirection > kIndicatorUpThreshold;
    bool isUp = this.yDirection < kIndicatorUpThreshold;

    this.color = isLeft
        ? kIndicatorLeftColor.withOpacity(
            min(this.xDirection.abs() / kIndicatorOpacityFactor, 1))
        : isRight
            ? kIndicatorRightColor.withOpacity(
                min(this.xDirection.abs() / kIndicatorOpacityFactor, 1))
            : isUp
                ? kIndicatorUpColor.withOpacity(
                    min(this.yDirection.abs() / kIndicatorOpacityFactor, 1))
                : Colors.transparent;

    var paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    var path = Path();
    path.addOval(Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: max(xDirection.abs() * kIndicatorRadiusSpeed,
          yDirection.abs() * kIndicatorRadiusSpeed),
    ));
    canvas.drawPath(path, paint);

    /// Text prompt
    final textStyle = ui.TextStyle(
      color: kIndicatorTextColor.withOpacity(max(
          min(this.xDirection.abs() / kIndicatorOpacityFactor, 1),
          min(this.yDirection.abs() / kIndicatorOpacityFactor, 1))),
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
          ? kIndicatorLeftMessage
          : isRight
              ? kIndicatorRightMessage
              : isUp
                  ? kIndicatorUpMessage
                  : '');
    final constraints = ui.ParagraphConstraints(width: 300);
    final paragraph = paragraphBuilder.build();
    paragraph.layout(constraints);
    final offset = Offset(
      size.width / 2 -
          (isLeft
              ? size.width / kIndicatorLeftOffsetDivisorX - size.width
              : isRight
                  ? size.width / kIndicatorRightOffsetDivisorX
                  : isUp
                      ? size.width / kIndicatorUpOffsetDivisorX
                      : 0),
      size.height / 2 + (isUp ? size.width / kIndicatorUpOffsetDivisorY : 0),
    );
    canvas.drawParagraph(paragraph, offset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
