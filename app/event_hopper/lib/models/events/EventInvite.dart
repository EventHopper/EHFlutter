import 'package:EventHopper/models/users/User.dart';

class EventInvite {
  final String inviteId;
  final User requester;
  final List<User> attendees;
  final List<RsvpUser> rsvpList;

  const EventInvite(
      {this.inviteId, this.requester, this.attendees, this.rsvpList});
  factory EventInvite.fromJson(Map<String, dynamic> json) {
    print(json);
    return EventInvite(
      inviteId: json['invite_id'],
      requester: User.fromJson(json['requester']),
    );
  }
}

class RsvpUser {
  final int state;
  final User user;

  const RsvpUser(this.state, this.user);

  factory RsvpUser.fromJson(Map<String, dynamic> json) {
    print(json);
    return RsvpUser(json['state'], User.fromJson(json['user']));
  }
}
