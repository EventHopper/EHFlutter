import 'dart:math';

import 'package:flutter/material.dart';
import 'package:EventHopper/models/users/User.dart';
import 'package:EventHopper/models/events/Event.dart';
import 'package:EventHopper/services/eh-server/api_service.dart';
import 'package:package_info/package_info.dart';

class SessionManager extends ChangeNotifier {
  String sessionID; //May be replaced by sessionToken or JWT or something
  User currentUser;
  int currentPage = 0;
  Future<List<Event>> eventsNearMe;
  Future<List<Event>> eventsFromCategory;
  bool initialStateLoaded = false;
  PackageInfo packageInfo;
  int index = 0;
  List<String> cities = [
    'Philadelphia',
    'New York',
    'Los Angeles',
    'Boston',
    'Dallas'
  ];
  var city = 'Philadelphia';

  void updateSessionID(String newID) {
    this.sessionID = newID;
    notifyListeners();
  }

  updatePackageInfo() async {
    this.packageInfo = await PackageInfo.fromPlatform();
    notifyListeners();
  }

  void nextCity() {
    index++;
    if (index >= cities.length) {
      index = 0;
    }
    city = cities[index];
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
    // this.eventsNearMe =
    //     apiService.getEventsByGeo('39.960863', '-75.6200333', 0.006);
    int page = Random().nextInt(25);
    int days = Random().nextInt(14);
    print('page is $page');
    this.eventsNearMe = apiService.getEventsByCity('$city',
        page: page, dateAfter: DateTime.now().add(new Duration(days: days)));
    notifyListeners();
  }

  void fetchEventsByCategory(String category) async {
    int page = Random().nextInt(9);
    this.eventsFromCategory =
        apiService.getEventsByCity('$city', page: page, categories: [category]);
    notifyListeners();
  }

  void clearEventsByCategory() async {
    this.eventsFromCategory = null;
    notifyListeners();
  }

  void updateInitialState(bool isLoaded) {
    this.initialStateLoaded = isLoaded;
    notifyListeners();
  }
}
