import 'package:EventHopper/services/eh-server/config.dart';
import 'package:flutter/foundation.dart';

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

  Uri getEventsByCity(String city, int page) => Uri(
      port: port,
      scheme: scheme,
      host: host,
      path: '/events',
      queryParameters: {'index': 'location', 'city': city, 'page': '$page'});

  Uri getEventsByGeo(String lat, String long, double radius) => Uri(
          port: port,
          scheme: scheme,
          host: host,
          path: '/events',
          queryParameters: {
            'index': 'location',
            'lat': lat,
            'long': long,
            'radius': '$radius'
          });

//**************************************************************** */
// EventHopper User Management API
//**************************************************************** */

  Uri registerUser() => Uri(
        port: port,
        scheme: scheme,
        host: host,
        path: '/users/register',
      );

  Uri initializeSession() => Uri(
        port: port,
        scheme: scheme,
        host: host,
        path: '/users/login',
      );

  Uri terminateSession() => Uri(
        port: port,
        scheme: scheme,
        host: host,
        path: '/users/logout',
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
}
