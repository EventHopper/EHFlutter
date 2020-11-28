import 'package:EventHopper/services/eh-server/api.dart';
import 'package:EventHopper/services/eh-server/api_service.dart';
import 'package:flutter/material.dart';
import 'package:EventHopper/models/users/User.dart';
import 'package:intl/intl.dart';

class Event {
  final String name, image, action;
  final DateTime date;
  final List<User> attendees;
  static const String defaultImage =
      'https://conceptdraw.com/a155c4/p149/preview/640/pict--schedule-cloud-round-icons-vector-stencils-library';

  Event({
    @required this.attendees,
    @required this.name,
    this.image = defaultImage,
    @required this.date,
    @required this.action,
  });

  factory Event.fromJson(Map<String, dynamic> eventSchema) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    String url = eventSchema['image_url_full'] as String;
    url = url != null ? url : eventSchema['image_url_small'] as String;
    url = url != null ? url : eventSchema['imageURL'] as String;

    return Event(
      name: eventSchema['name'] as String,
      image: url != null ? url : defaultImage,
      date: dateFormat.parse(eventSchema['start_date_local']),
      attendees: users..shuffle(),
      action: eventSchema['public_action'] as String,
    );
  }
}

List<User> users = [user1, user2, user3];
