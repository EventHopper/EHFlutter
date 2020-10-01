import 'package:EventHopper/services/eh-server/api.dart';
import 'package:EventHopper/services/eh-server/api_service.dart';
import 'package:flutter/material.dart';
import 'package:EventHopper/models/User.dart';
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

Future<List<Event>> getEvents() async {
  final apiService = APIService(API.sandbox());
  List<Event> events = await apiService.getEvents();
  print('getEvents Reached with events: ' + events.toString());
  return events;
}

// List<Event> events = [
//   Event(
//     attendees: users..shuffle(),
//     name: "Alec Benjamin",
//     image:
//         "https://s1.ticketm.net/dam/a/423/97ce41f8-bcbf-4048-b995-c84a02451423_1262171_RETINA_PORTRAIT_16_9.jpg",
//     date: DateTime(2021, 10, 09, 00, 30, 00),
//   ),
//   Event(
//     attendees: users..shuffle(),
//     name: "Jim Gaffigan: The Pale Tourist",
//     image:
//         "https://s1.ticketm.net/dam/a/ebb/b777581f-13db-42a2-8c23-6a0a21deeebb_1245481_CUSTOM.jpg",
//     date: DateTime(2021, 8, 10),
//   ),
//   Event(
//     attendees: users..shuffle(),
//     name: "Marshmello",
//     image:
//         "https://s1.ticketm.net/dam/a/e60/91d8db88-2c00-496b-885c-e4124c9f5e60_1305901_TABLET_LANDSCAPE_16_9.jpg",
//     date: DateTime(2021, 10, 15),
//   ),
//   Event(
//     attendees: users..shuffle(),
//     name: "Deftones Summer Tour 2021",
//     image:
//         "https://s1.ticketm.net/dam/a/12f/2b72930c-ea97-4223-b94e-60df7f52012f_1286421_TABLET_LANDSCAPE_16_9.jpg",
//     date: DateTime(2022, 10, 15),
//   ),
// ];

List<User> users = [user1, user2, user3];
