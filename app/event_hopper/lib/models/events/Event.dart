import 'package:EventHopper/services/eh-server/api.dart';
import 'package:EventHopper/services/eh-server/api_service.dart';
import 'package:flutter/material.dart';
import 'package:EventHopper/models/users/User.dart';
import 'package:intl/intl.dart';

class Event {
  final String name, image, action;
  final DateTime date;
  final List<User> attendees;

  Event({
    @required this.attendees,
    @required this.name,
    @required this.image,
    @required this.date,
    @required this.action,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    return Event(
      name: json['name'] as String,
      image: json['image_url_full'] as String,
      date: dateFormat.parse(json['start_date_local']),
      attendees: users..shuffle(),
      action: json['public_action'] as String,
    );
  }
}

List<User> users = [user1, user2, user3];
