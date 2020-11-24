import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:EventHopper/models/events/Event.dart';
import 'package:EventHopper/models/users/User.dart';

import '../utils/constants.dart';
import '../utils/size_config.dart';

class PlaceCard extends StatelessWidget {
  const PlaceCard({
    Key key,
    @required this.eventSpotlight,
    this.isFullCard = false,
    @required this.press,
  }) : super(key: key);

  final Event eventSpotlight;
  final bool isFullCard;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(isFullCard ? 158 : 137),
      child: GestureDetector(
        onTap: () {
          press();
        },
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: isFullCard ? 1.09 : 1.29,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  image: DecorationImage(
                      image: NetworkImage(eventSpotlight.image),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            Container(
              width: getProportionateScreenWidth(isFullCard ? 158 : 137),
              padding: EdgeInsets.all(
                getProportionateScreenWidth(kDefaultPadding),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [kDefualtShadow],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    eventSpotlight.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: isFullCard ? 17 : 12,
                    ),
                  ),
                  if (isFullCard)
                    Text(
                      eventSpotlight.date.day.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  if (isFullCard)
                    Text(
                      DateFormat.MMMM().format(eventSpotlight.date) +
                          " " +
                          eventSpotlight.date.year.toString(),
                    ),
                  VerticalSpacing(of: 10),
                  Attendees(
                    users: eventSpotlight.attendees,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Attendees extends StatelessWidget {
  const Attendees({
    Key key,
    @required this.users,
  }) : super(key: key);

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    int totalUser = 0;
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenWidth(30),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ...List.generate(
            3,
            (index) {
              totalUser++;
              return Positioned(
                left: (22 * index).toDouble(),
                child: buildUserFace(index),
              );
            },
          ),
          Positioned(
            left: (22 * totalUser).toDouble(),
            child: Container(
              height: getProportionateScreenWidth(28),
              width: getProportionateScreenWidth(28),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  ClipOval buildUserFace(int index) {
    return ClipOval(
      child: Image.network(
        users[index].image,
        height: getProportionateScreenWidth(28),
        width: getProportionateScreenWidth(28),
        fit: BoxFit.cover,
      ),
    );
  }
}
