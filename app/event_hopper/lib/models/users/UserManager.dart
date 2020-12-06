import 'dart:convert';

import 'package:EventHopper/models/events/Event.dart';
import 'package:EventHopper/models/users/User.dart';

class UserManager {
  List<Event> eventLeft;
  List<Event> eventRight;
  List<Event> bookmarked;
  List<Event> eventUp;

  UserManager({this.eventLeft, this.eventRight, this.bookmarked, this.eventUp});

  factory UserManager.fromJson(Map<String, dynamic> json) {
    return UserManager(
      eventLeft: UserManager.fromEventList(jsonDecode(json['event_left'])),
      eventRight: UserManager.fromEventList(jsonDecode(json['event_right'])),
      eventUp: UserManager.fromEventList(jsonDecode(json['event_up'])),
      bookmarked: UserManager.fromEventList(jsonDecode(json['bookmarked'])),
    );
  }

  static List<Event> fromEventList(List<dynamic> data) {
    List<Event> events =
        data.map((dynamic item) => Event.fromJson(item)).toList();
    return events;
  }
}
