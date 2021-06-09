import 'package:flutter/material.dart';
import 'package:googleapis/workflowexecutions/v1.dart';
import 'package:intl/intl.dart';
import 'package:EventHopper/models/events/Event.dart';
import 'package:EventHopper/models/users/User.dart';

import '../../utils/constants.dart';
import '../../utils/size_config.dart';

class EventCard extends StatelessWidget {
  const EventCard({
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
      width: getProportionateScreenWidth(274),
      child: Material(
        child: GestureDetector(
          onTap: () {
            press();
          },
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1.3,
                child: Material(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      Ink.image(
                          child: InkWell(
                            onTap: () {
                              press();
                            },
                          ),
                          image: NetworkImage(eventSpotlight.image),
                          fit: BoxFit.cover),
                      // ColorFiltered(
                      //   colorFilter: ColorFilter.mode(
                      //       Colors.black.withOpacity(0.6), BlendMode.dstIn),
                      //   child: Container(
                      //     height: getProportionateScreenHeight(315),
                      //     width: double.infinity,
                      //     color: Colors.black,
                      //   ),
                      // ),
                      Container(
                        height: 300.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            gradient: LinearGradient(
                                begin: FractionalOffset.topCenter,
                                end: FractionalOffset.bottomCenter,
                                colors: [
                                  Colors.grey.withOpacity(0.0),
                                  Colors.black.withOpacity(0.8),
                                  Colors.black,
                                ],
                                stops: [
                                  0.0,
                                  0.75,
                                  1.0
                                ])),
                      ),
                      Positioned(
                        width: 250,
                        left: 10,
                        bottom: 60,
                        child: Text(
                          eventSpotlight.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      VerticalSpacing(of: 10),
                      Positioned(
                        width: 200,
                        left: 15,
                        bottom: 15,
                        child: Attendees(
                          users: eventSpotlight.attendees,
                        ),
                      ),
                      Positioned(
                          width: 250,
                          left: 160,
                          bottom: 15,
                          child: EventSourceLogo(vendorId: '001')),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EventSourceLogo extends StatelessWidget {
  final String vendorId;

  const EventSourceLogo({this.vendorId});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenWidth(40),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            child: Container(
              height: 15,
              child: Image.network(
                  'https://user-images.githubusercontent.com/24496327/121301188-d144ed80-c8c5-11eb-9127-85ae0f09dc3a.png'),
            ),
          ),
          Positioned(
            left: 18,
            child: Container(
              height: vendorId == '001' ? 10 : 15,
              child: Image.network(vendorId == '001'
                  ? 'https://user-images.githubusercontent.com/24496327/121301109-b4101f00-c8c5-11eb-88d9-45c4ee89e14c.png'
                  : vendorId == '002'
                      ? 'https://user-images.githubusercontent.com/24496327/121300977-86c37100-c8c5-11eb-9104-bc971a8ab6bd.png'
                      : 'https://user-images.githubusercontent.com/24496327/121300977-86c37100-c8c5-11eb-9104-bc971a8ab6bd.png'),
            ),
          )
        ],
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
      height: getProportionateScreenWidth(40),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ...List.generate(
            4,
            (index) {
              totalUser++;
              return Positioned(
                left: (22 * index).toDouble(),
                child: buildUserFace(index),
              );
            },
          ),
          Positioned(
            bottom: 3,
            left: (26 * totalUser).toDouble(),
            child: Container(
              height: getProportionateScreenWidth(28),
              width: getProportionateScreenWidth(28),
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Text(
                '+12',
                style: TextStyle(color: Colors.white),
              ),
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
        height: getProportionateScreenWidth(35),
        width: getProportionateScreenWidth(35),
        fit: BoxFit.cover,
      ),
    );
  }
}
