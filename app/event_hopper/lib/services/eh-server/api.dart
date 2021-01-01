import 'package:EventHopper/services/eh-server/config.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

enum Endpoint { events, eventsNearMe, users }

class API {
//**************************************************************** */
//API Configuration Setup
//**************************************************************** */
  final String apiKey;
  API({@required this.apiKey});
  factory API.sandbox() => API(apiKey: APIConfig.ehKeySandbox);
  factory API.production() => API(apiKey: APIConfig.ehKeyProduction);

  static final bool dev = false;
  static final String scheme = dev ? 'http' : 'https';
  static final String host = dev ? APIConfig.sandboxHost : APIConfig.prodHost;
  static final int port = dev ? APIConfig.sandboxPort : APIConfig.prodPort;
//**************************************************************** */

//**************************************************************** */
// EventHopper Events API
//**************************************************************** */

  Uri getEvent(String id) => Uri(
      port: port,
      scheme: scheme,
      host: host,
      path: '/events',
      queryParameters: {'index': 'id', 'id': id});

  Uri getEventsByCity(String city,
      {int page,
      int limit,
      DateTime dateBefore,
      DateTime dateAfter,
      List<String> category,
      List<String> tags}) {
    Map<String, String> queryParameters = {'index': 'location', 'city': city};

    queryParameters.addAll(_createEventQueryParameters(
        page: page,
        limit: limit,
        dateBefore: dateBefore,
        dateAfter: dateAfter,
        category: category,
        tags: tags));

    return _buildUri(queryParameters);
  }

  Uri getEventsByVenue(String venue,
      {int page,
      int limit,
      DateTime dateBefore,
      DateTime dateAfter,
      List<String> category,
      List<String> tags}) {
    Map<String, String> queryParameters = {'index': 'location', 'venue': venue};

    queryParameters.addAll(_createEventQueryParameters(
        page: page,
        limit: limit,
        dateBefore: dateBefore,
        dateAfter: dateAfter,
        category: category,
        tags: tags));

    return _buildUri(queryParameters);
  }

  Uri getEventsByGeo(String lat, String long, double radius,
      {int page,
      int limit,
      DateTime dateBefore,
      DateTime dateAfter,
      List<String> category,
      List<String> tags}) {
    Map<String, String> queryParameters = {
      'index': 'location',
      'lat': lat,
      'long': long,
      'radius': '$radius'
    };

    queryParameters.addAll(_createEventQueryParameters(
        page: page,
        limit: limit,
        dateBefore: dateBefore,
        dateAfter: dateAfter,
        category: category,
        tags: tags));

    return _buildUri(queryParameters);
  }

//**************************************************************** */
// EventHopper User Management API
//**************************************************************** */

  Uri registerUser() => Uri(
        port: port,
        scheme: scheme,
        host: host,
        path: '/users/register',
      );

  Uri getUsers() => Uri(
        port: port,
        scheme: scheme,
        host: host,
        path: '/users',
      );

  Uri searchUsers() => Uri(
        port: port,
        scheme: scheme,
        host: host,
        path: '/search/users',
      );

  Uri getUser(String username) => Uri(
        port: port,
        scheme: scheme,
        host: host,
        path: '/users/$username',
      );

  Uri getUserEventList(String listType, String userID) => Uri(
        port: port,
        scheme: scheme,
        host: host,
        path: '/users/manager/$userID/$listType',
      );

//**************************************************************** */
// EventHopper Swipe Management API
//**************************************************************** */

  Uri swipeEntry(String uid) => Uri(
        port: port,
        scheme: scheme,
        host: host,
        path: '/users/swipe/$uid',
      );

//**************************************************************** */
// WORK IN PROGRESS BELOW
//**************************************************************** */

  Uri endpintUri(Endpoint endpoint) => Uri(
        scheme: dev ? 'http' : 'https',
        host: dev ? APIConfig.sandboxHost : APIConfig.prodHost,
        path: '${_paths[endpoint]}',
      );

  static Map<Endpoint, String> _paths = {
    Endpoint.events: '/events',
    Endpoint.eventsNearMe: '/events/?index=location&city=Philadelphia',
  };

  Map<String, String> _createEventQueryParameters(
      {int page,
      int limit,
      DateTime dateBefore,
      DateTime dateAfter,
      List<String> category,
      List<String> tags}) {
    Map<String, String> map = {};
    page != null ? map.putIfAbsent('page', () => '$page') : () {};
    limit != null ? map.putIfAbsent('limit', () => '$limit') : () {};
    dateBefore != null
        ? map.putIfAbsent('date_before', () => dateBefore.toString())
        : () {};
    // print(dateAfter.toIso8601String());
    dateAfter != null
        ? map.putIfAbsent('date_after', () => dateAfter.toString())
        : () {};
    category != null
        ? map.putIfAbsent('category', () => category.join(',').toString())
        : () {};
    tags != null ? map.putIfAbsent('tags', () => tags.join(',')) : () {};
    return map;
  }

  Uri _buildUri(Map<String, String> queryParameters) {
    print(Uri(
            port: port,
            scheme: scheme,
            host: host,
            path: '/events',
            queryParameters: queryParameters)
        .toString());
    return Uri(
        port: port,
        scheme: scheme,
        host: host,
        path: '/events',
        queryParameters: queryParameters);
  }
}
