import 'package:flutter/material.dart';
import 'package:EventHopper/models/events/Event.dart';
import 'package:intl/intl.dart';

class ProfileCardAlignment extends StatelessWidget {
  final int cardNum;
  final Event eventSpotlight;
  ProfileCardAlignment(this.cardNum, this.eventSpotlight);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: Material(
                shadowColor: Colors.transparent,
                elevation: 3,
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.circular(16.0),
                child: Ink.image(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    this.eventSpotlight.image,
                  ),
                  child: InkWell(
                    onTap: () {},
                  ),
                )),
          ),
          SizedBox.expand(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black54],
                      begin: Alignment.center,
                      end: Alignment.bottomCenter)),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('${eventSpotlight.name}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700)),
                    Padding(padding: EdgeInsets.only(bottom: 8.0)),
                    Text(
                        '${eventSpotlight.date.day.toString() + " " + DateFormat.MMMM().format(eventSpotlight.date) + " " + eventSpotlight.date.year.toString()}',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.white)),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
