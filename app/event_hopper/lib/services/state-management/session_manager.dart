import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:flutter/material.dart';
import 'package:EventHopper/models/users/User.dart';
import 'package:EventHopper/models/events/Event.dart';
import 'package:EventHopper/services/eh-server/api_service.dart';
import 'package:package_info/package_info.dart';

class SessionManager extends ChangeNotifier {
  String sessionID; //May be replaced by sessionToken or JWT or something
  Future<User> currentUser;
  Future<Map<String, dynamic>> otherUserProfileView;
  int currentPage = 0;
  Future<List<Event>> eventsNearMe;
  Future<List<Event>> eventsFromCategory;

  Future<List<User>> search = new Future(() => null);
  bool initialStateLoaded = false;
  Future<PackageInfo> packageInfo;
  int index = 0;

  List<Event> eventLeft = <Event>[];
  int eventLeftCount;

  List<Event> eventUp = <Event>[];
  int eventUpCount;

  List<Event> eventRight = <Event>[];
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

  Future<List<User>> updateSearch(String query) {
    this.search = eventHopperApiService.searchUsers(query);
    notifyListeners();
    return this.search;
  }

  void updateSessionID(String newID) {
    this.sessionID = newID;
    notifyListeners();
  }

  updatePackageInfo() async {
    this.packageInfo = PackageInfo.fromPlatform();
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

  void updateUser() {
    this.currentUser = eventHopperApiService.getLoggedInUserData();
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
    int page = Random().nextInt(10);
    int days = Random().nextInt(60);
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
    if (category == 'Random') {
      this.eventsFromCategory = eventHopperApiService.getEventsByCity('$city',
          page: page, isRandom: true);
    } else {
      this.eventsFromCategory = eventHopperApiService
          .getEventsByCity('$city', page: page, categories: [category]);
    }
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
    this.currentUser = new Future<User>(() => new User(
        username: 'anon',
        fullName: 'anonymous',
        image:
            'https://assets-global.website-files.com/5b5aa355afe474a8b1329a37/5ecd4938ec0ff060bfac3899_anonymous%20feedback.jpg',
        email: 'anonymous@eventhopper.app'));
    this.currentPage = 0;
    this.eventsNearMe = null;
    this.eventsFromCategory = null;
    this.initialStateLoaded = false;
    this.search = new Future(() => null);
    this.index = 0;

    this.eventLeft = <Event>[];
    this.eventLeftCount = 0;

    this.eventUp = <Event>[];
    this.eventUpCount = 0;

    this.eventRight = <Event>[];
    this.eventRightCount = 0;

    this.eventTotalCount = 0;
    notifyListeners();
  }

  void fetchCurrentUserData() async {
    this.currentUser = eventHopperApiService.getLoggedInUserData()
      ..then((value) => value..image += '?q=${Random.secure().nextDouble()}');
    notifyListeners();
  }

  void fetchOtherUserProfileViewData(String username) async {
    String currentUsername = (await this.currentUser).username;
    this.otherUserProfileView = eventHopperApiService.getUser(username,
        relatedTo: currentUsername)
      ..then((value) =>
          value['user']..image += '?q=${Random.secure().nextDouble()}');
    notifyListeners();
  }
}
