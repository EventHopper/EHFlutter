import 'package:EventHopper/models/users/User.dart';
import 'package:flutter/material.dart';

class Relationship {
  final String id;
  final User user;
  final String recipientId;
  final String requesterId;
  final int state;

  Relationship(
      {@required this.id,
      @required this.user,
      @required this.state,
      @required this.recipientId,
      @required this.requesterId});

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

  Map<String, dynamic> toJSON() => {
        "_id": "6060cf21a98c432970eb249e",
        "requester_id": "3LoUabnfbNfwgieGST7aVfSMk3l2",
        "recipient_id": "QrjnlekSYgTdoBNNXXFgsceroaS2",
        "state": 1,
        "createdAt": "2021-03-28T18:46:57.595Z",
        "updatedAt": "2021-03-28T18:46:57.595Z",
        "__v": 0,
        "recipient": {
          "_id": "6060ce6c7a22e743b6ece6cc",
          "user_id": "QrjnlekSYgTdoBNNXXFgsceroaS2",
          "full_name": "Micahel Jordan",
          "image_url":
              "https://media.gq.com/photos/5e99bf6fe5102200088e8eb2/3:4/w_1107,h_1476,c_limit/GQ-MichaelJordan-041720.jpg",
          "username": "jumpman23"
        },
        "requester": {
          "_id": "5fdabbd1fb72c46345badb69",
          "user_id": "3LoUabnfbNfwgieGST7aVfSMk3l2",
          "full_name": "Johnny Karate",
          "image_url": "null",
          "username": "kanga"
        },
        "id": "6060cf21a98c432970eb249e"
      };
}

var defaultRelationship = Relationship.fromJson(
    new Relationship().toJSON(), '3LoUabnfbNfwgieGST7aVfSMk3l2');
