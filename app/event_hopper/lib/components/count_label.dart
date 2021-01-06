import 'package:EventHopper/utils/constants.dart';
import 'package:flutter/material.dart';

class CountLabel extends StatefulWidget {
  final int counter;
  final Color color;

  CountLabel(this.counter, {this.color});

  @override
  _CountLabelState createState() => _CountLabelState();
}

class _CountLabelState extends State<CountLabel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Stack(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.all(1),
            decoration: new BoxDecoration(
              color: widget.color != null ? widget.color : kTextColor,
              borderRadius: BorderRadius.circular(12),
            ),
            constraints: BoxConstraints(
              minWidth: 40,
              minHeight: 30,
            ),
            child: new Text(
              widget.counter < 200 ? '${widget.counter}' : '200+',
              style: new TextStyle(
                color: Colors.white,
                fontSize: 16,
                textBaseline: TextBaseline.ideographic,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
