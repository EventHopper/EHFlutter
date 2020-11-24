import 'package:flutter/material.dart';
import 'package:EventHopper/models/users/User.dart';
import 'package:EventHopper/models/events/Event.dart';
import 'package:EventHopper/services/eh-server/api_service.dart';

class SessionManager extends ChangeNotifier {
  String sessionID; //May be replaced by sessionToken or JWT or something
  User currentUser;
  int currentPage = 0;
  Future<List<Event>> eventsNearMe;
  bool initialStateLoaded = false;

  void updateSessionID(String newID) {
    this.sessionID = newID;
    notifyListeners();
  }

  void updateCurrentPage(int page) {
    this.currentPage = page;
    notifyListeners();
  }

  void updateUser(User newUser) {
    this.currentUser = newUser;
    notifyListeners();
  }

  void terminateSession() {
    sessionID = null;
    currentUser = null;
    notifyListeners();
  }

  void fetchEventsNearMe() async {
    this.eventsNearMe =
        apiService.getEventsByGeo('39.960863', '-75.6200333', 0.006);

    notifyListeners();
  }

  void updateInitialState(bool isLoaded) {
    this.initialStateLoaded = isLoaded;
    notifyListeners();
  }
}
