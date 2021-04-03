import 'package:EventHopper/services/services-config.dart';
import 'package:flutter/foundation.dart';

class API {
//**************************************************************** */
//API Configuration Setup
//**************************************************************** */
  final APIEnvironmentConfig environment;
  String scheme;
  String host;
  int port;
  API({@required this.environment}) {
    scheme = this.environment.name != Environment.PRODUCTION ? 'http' : 'https';
    host = this.environment.host;
    port = this.environment.name != Environment.PRODUCTION
        ? this.environment.port
        : null;
  }
  factory API.local() => API(environment: new LocalEnvironment());
  factory API.sandbox() => API(environment: new SandboxEnvironment());
  factory API.production() => API(environment: new ProductionEnvironment());

  String get apiKey => this.environment.key;

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
      List<String> tags,
      bool isRandom = false}) {
    Map<String, String> queryParameters = {
      'index': isRandom ? 'random' : 'location',
      'city': city
    };
    if (isRandom) {
      queryParameters.putIfAbsent('size', () => '16');
    }

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

  Uri searchUsers(String query) => Uri(
        port: port,
        scheme: scheme,
        host: host,
        path: '/search/users',
        queryParameters: {'query': query},
      );

  Uri getUser(String username, {String userID}) {
    Uri finalUri = userID == null
        ? Uri(
            port: port,
            scheme: scheme,
            host: host,
            path: '/users/$username',
          )
        : Uri(
            port: port,
            scheme: scheme,
            host: host,
            path: '/users/$username',
            queryParameters: {
                'related_to': userID,
              });

    return finalUri;
  }

  Uri getUserEventList(String listType, String userID) => Uri(
        port: port,
        scheme: scheme,
        host: host,
        path: '/users/manager/$userID/$listType',
      );

  Uri grantOAuth(String userID) => Uri(
        port: port,
        scheme: scheme,
        host: host,
        path: '/users/$userID/oauth/grant',
      );

  Uri revokeOAuth(String userID) => Uri(
        port: port,
        scheme: scheme,
        host: host,
        path: '/users/$userID/oauth/revoke',
      );

  Uri addEventToCalendar(String uid) => Uri(
        port: port,
        scheme: scheme,
        host: host,
        path: '/calendar/create/$uid',
      );

  Uri uploadUserMedia(String uid) => Uri(
        port: port,
        scheme: scheme,
        host: host,
        path: '/users/media/$uid',
      );

  Uri getUserUserRelationships(String uid, String state,
      {String relationshipID}) {
    Uri finalUri = Uri(
        port: port,
        scheme: scheme,
        host: host,
        path: '/users/network/relationships/',
        queryParameters: {
          'user_id': uid,
          'state': state,
        });
    if (relationshipID != null) {
      finalUri.queryParameters
          .putIfAbsent('relationship_id', () => relationshipID);
    }

    return finalUri;
  }

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
