import 'dart:convert';
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

  List<Event> eventLeft = new List<Event>();
  int eventLeftCount;

  List<Event> eventUp = new List<Event>();
  int eventUpCount;

  List<Event> eventRight = new List<Event>();
  int eventRightCount;

  int eventTotalCount = 0;

  var city = 'Philadelphia';

  List<String> cities = [
    'Philadelphia',
    'New York',
    'Los Angeles',
    'Boston',
    'Dallas'
  ];

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

  void updateUserLists(int page) {
    this.currentPage = page;
    notifyListeners();
  }

  void fetchEventsNearMe() async {
    // this.eventsNearMe =
    //     apiService.getEventsByGeo('39.960863', '-75.6200333', 0.006);
    int page = Random().nextInt(25);
    int days = Random().nextInt(14);
    print('page is $page');
    this.eventsNearMe = eventHopperApiService.getEventsByCity('$city',
        page: page, dateAfter: DateTime.now().add(new Duration(days: days)));
    notifyListeners();
  }

  void fetchUserEventLists() {
    print('running');
    eventTotalCount = 0;
    getLeftMap();
    getUpMap();
    getRightMap();

    notifyListeners();
    print('notified');
  }

  void getLeftMap() async {
    var eventLeftMap =
        await eventHopperApiService.getUserEventList('event_left');
    this.eventLeft = eventLeftMap['events'] as List<Event>;
    this.eventLeftCount = eventLeftMap['count'];
    print('done left');
    notifyListeners();
    print('notified');
  }

  void getUpMap() async {
    var eventUpMap = await eventHopperApiService.getUserEventList('event_up');
    this.eventUp = eventUpMap['events'] as List<Event>;
    this.eventTotalCount += eventUpMap['count'];
    this.eventUpCount = eventUpMap['count'];
    print('done up');
    notifyListeners();
    print('notified');
  }

  void getRightMap() async {
    var eventRightMap =
        await eventHopperApiService.getUserEventList('event_right');
    this.eventRight = eventRightMap['events'] as List<Event>;
    this.eventTotalCount += eventRightMap['count'];
    this.eventRightCount = eventRightMap['count'];
    print('done right');
    notifyListeners();
    print('notified');
  }

  void incrementEventTotalCount() async {
    eventTotalCount++;
    notifyListeners();
  }

  void incrementEventLeftCount() async {
    eventLeftCount++;
    notifyListeners();
  }

  void incrementEventRightCount() async {
    eventRightCount++;
    notifyListeners();
  }

  void incrementEventUpCount() async {
    eventUpCount++;
    notifyListeners();
  }

  bool addEventUp(Event event) {
    if (!eventUp.contains(event)) {
      eventUp.add(event);
      notifyListeners();
      return true;
    }
    return false;
  }

  bool addEventRight(Event event) {
    if (!eventRight.contains(event)) {
      eventRight.add(event);
      notifyListeners();
      return true;
    }
    return false;
  }

  bool addEventLeft(Event event) {
    if (!eventLeft.contains(event)) {
      eventLeft.add(event);
      notifyListeners();
      return true;
    }
    return false;
  }

  void fetchEventsByCategory(String category) async {
    int page = Random().nextInt(9);
    this.eventsFromCategory = eventHopperApiService
        .getEventsByCity('$city', page: page, categories: [category]);
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

  void wipeState() {
    this.sessionID = null; //May be replaced by sessionToken or JWT or something
    this.currentUser = null;
    this.currentPage = 0;
    this.eventsNearMe = null;
    this.eventsFromCategory = null;
    this.initialStateLoaded = false;
    this.index = 0;

    this.eventLeft = new List<Event>();
    this.eventLeftCount = 0;

    this.eventUp = new List<Event>();
    this.eventUpCount = 0;

    this.eventRight = new List<Event>();
    this.eventRightCount = 0;

    this.eventTotalCount = 0;
    notifyListeners();
  }
}
