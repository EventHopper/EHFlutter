import 'package:EventHopper/components/friend_request.dart';
import 'package:EventHopper/models/users/Relationship.dart';
import 'package:EventHopper/screens/friends/components/no_friends.dart';
import 'package:flutter/material.dart';
import 'package:EventHopper/utils/constants.dart';
import 'package:EventHopper/utils/size_config.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:EventHopper/services/eh-server/api_service.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Future<List<Event>> events = getEvents();

    // List<Relationship> relationships = [
    //   defaultRelationship,
    //   defaultRelationship,
    //   defaultRelationship,
    //   defaultRelationship,
    //   defaultRelationship,
    //   defaultRelationship,
    //   defaultRelationship,
    // ];
    return FutureBuilder(
        future: Future.wait([
          eventHopperApiService.getUserRelationships(1),
          eventHopperApiService.getUserRelationships(2)
        ]),
        builder: (context, relationships) {
          if (relationships.connectionState == ConnectionState.none &&
                  relationships.hasData == null ||
              !relationships.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: getProportionateScreenHeight(600),
                  child: SpinKitRotatingCircle(
                    color: kTextColor,
                    size: 50.0,
                  ),
                ),
              ],
            );
          }
          if (relationships.hasData) {
            List<Relationship> recievedFriendRequests =
                relationships.data[0]['relationship_list'];
            List<Relationship> friends =
                relationships.data[1]['relationship_list'];

            List<Relationship> allRelationships =
                [recievedFriendRequests, friends].expand((x) => x).toList();

            if (allRelationships.length < 1) {
              return NoFriendsMessage();
            }
            print(allRelationships);
            return ListView.builder(
              itemCount: allRelationships.length,
              itemBuilder: (BuildContext context, int index) {
                return new FriendRequest(relationship: allRelationships[index]);
              },
            );
          }
          return null;
        });
  }
}
