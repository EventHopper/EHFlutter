import 'package:EventHopper/models/users/User.dart';
import 'package:flutter/material.dart';

class Relationship {
  final String id;
  User user;
  String recipientId;
  String requesterId;
  int state;

  Relationship(
      {@required this.id,
      @required this.user,
      @required this.state,
      @required this.recipientId,
      @required this.requesterId});

  factory Relationship.noRelation({User user}) {
    return Relationship(
      id: null,
      user: user,
      requesterId: null,
      recipientId: null,
      state: 0,
    );
  }

  factory Relationship.fromJson(Map<String, dynamic> relationshipSchema,
      [String currentUserID]) {
    print('serverSide: ' +
        relationshipSchema['recipient_id'].toString() +
        '\nfirebase:' +
        currentUserID.toString());
    User otherUser = (relationshipSchema['recipient_id'] == currentUserID)
        ? User.fromJson(relationshipSchema['requester'])
        : (relationshipSchema['requester_id'] == currentUserID)
            ? User.fromJson(relationshipSchema['recipient'])
            : null;

    return Relationship(
      id: relationshipSchema['_id'] as String,
      user: otherUser,
      requesterId: relationshipSchema['requester_id'],
      recipientId: relationshipSchema['recipient_id'],
      state: relationshipSchema['state'] as int,
    );
  }
  @override
  String toString() {
    String returnString =
        '${this.requesterId} --> ${this.recipientId}\n${this.user}';
    return returnString;
  }
}
