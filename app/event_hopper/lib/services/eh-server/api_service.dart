import 'dart:convert';
import 'dart:developer';
import 'package:EventHopper/models/events/Event.dart';
import 'package:EventHopper/models/users/Relationship.dart';
import 'package:EventHopper/models/users/User.dart';
import 'package:EventHopper/services/services-config.dart';
import 'package:http/http.dart' as http;
import 'package:EventHopper/services/eh-server/api.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

final eventHopperApiService = APIService(API.sandbox());

class APIService {
  final API api;
  APIService(this.api);

  Future<dynamic> getUser(
    String username, {
    String relatedTo,
    bool isCurrentUser,
  }) async {
    final url = isCurrentUser
        ? api
            .getUser(username,
                userID: fbAuth.FirebaseAuth.instance.currentUser.uid)
            .toString()
        : api.getUser(username, userID: relatedTo).toString();
    log(url);
    final client = new http.Client();
    final response = await client
        .get(Uri.parse(url), headers: {'Authorization': '${api.apiKey}'});
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      User user = User.fromJson(data['user']);
      if (data['relationship'] != null) {
        Relationship relationship = Relationship.fromJson(data['relationship']);
        return Future<Map<String, dynamic>>(
            () => {'user': user, 'relationship': relationship});
      }
      return user;
    } else {
      throw ('Request get User $username failed' +
          '\nResponse:${response.statusCode}\n${response.reasonPhrase}');
    }
  }

  Future<List<User>> searchUsers(String query) async {
    final url = api.searchUsers(query).toString();
    print(url);
    final client = new http.Client();
    final response = await client
        .get(Uri.parse(url), headers: {'Authorization': '${api.apiKey}'});

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<User> users =
          data.map((dynamic item) => User.fromJson(item)).toList();
      return users;
    } else {
      throw ('Request search users $query failed' +
          '\nResponse:${response.statusCode}\n${response.reasonPhrase}');
    }
  }

  Future<List<Event>> getEventsByCity(String city,
      {List<String> categories,
      DateTime dateAfter,
      DateTime dateBefore,
      int page,
      bool isRandom = false}) async {
    final url = isRandom
        ? api
            .getEventsByCity(
              city,
              page: page != null ? page : 0,
              dateAfter: dateAfter != null ? dateAfter : DateTime.now(),
              category: categories != null ? categories : null,
              isRandom: isRandom,
              //Change to user  default category preference(s)
            )
            .toString()
        : api
            .getEventsByCity(
              city,
              page: page != null ? page : 0,
              dateAfter: dateAfter != null ? dateAfter : DateTime.now(),
              category: categories != null ? categories : null,

              //Change to user  default category preference(s)
            )
            .toString();
    log(url);
    final client = new http.Client();
    final response = await client
        .get(Uri.parse(url), headers: {'Authorization': '${api.apiKey}'});
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Event> events =
          data.map((dynamic item) => Event.fromJson(item)).toList();
      return events;
    } else {
      throw ('Request ${url} failed' +
          '\nResponse:${response.statusCode}\n${response.reasonPhrase}');
    }
  }

//'39.960863', '-75.6200333', 2
  Future<List<Event>> getEventsByGeo(
      String lat, String long, double radius) async {
    final url = api.getEventsByGeo(lat, long, radius).toString();
    log(url);

    final client = new http.Client();
    final response = await client
        .get(Uri.parse(url), headers: {'Authorization': '${api.apiKey}'});
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Event> events =
          data.map((dynamic item) => Event.fromJson(item)).toList();
      return events;
    } else {
      throw ('Request ${api.getEventsByGeo(lat, long, radius)} failed' +
          '\nResponse:${response.statusCode}\n${response.reasonPhrase}');
    }
  }

  Future<dynamic> registerUser(
      {String username, String password, String email, String fullName}) async {
    final url = api.registerUser().toString();
    print(url);
    final client = new http.Client();
    final response = await client.post(Uri.parse(url), headers: {
      'Authorization': '${api.apiKey}',
    }, body: {
      "username": username,
      "password": password,
      "email": email,
      "full_name": fullName
    });
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw ('Request ${api.registerUser()} failed' +
          '\nResponse:${response.statusCode}\n${response.reasonPhrase}');
    }
  }

  Future<dynamic> swipeEntry({
    String direction,
    String eventId,
  }) async {
    fbAuth.User currentUser = fbAuth.FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return;
    }

    String userId = currentUser.uid;
    final url = api.swipeEntry(eventId).toString();
    print(url);
    print(direction);
    String encoded = json.encode({
      "user_id": "$userId",
      "direction": "$direction",
      "event_manager_update": {"${direction}_swipe": "$userId"},
      "user_manager_update": {"$direction": "$eventId"},
    });

    print(encoded);

    final client = new http.Client();
    final response = await client.post(
      Uri.parse(url),
      headers: {
        'Authorization': '${api.apiKey}',
      },
      body: encoded,
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw ('Request ${api.swipeEntry(userId)} failed' +
          '\nResponse:${response.statusCode}\n${response.reasonPhrase}');
    }
  }

  Future<Map<dynamic, dynamic>> getUserEventList(
    String listType,
  ) async {
    fbAuth.User currentUser = fbAuth.FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return {};
    }

    String userId = currentUser.uid;
    final url = api.getUserEventList(listType, userId).toString();
    print(url);
    final client = new http.Client();
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Authorization': '${api.apiKey}',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['events'];
      return {
        'events': data.map((dynamic item) => Event.fromJson(item)).toList(),
        'count': jsonDecode(response.body)['count'] as int,
      };
    } else {
      throw ('Request ${api.getUserEventList(listType, userId)} failed' +
          '\nResponse:${response.statusCode}\n${response.reasonPhrase}');
    }
  }

  /// Requires a [Service Provider Name], [clientID] and [refreshToken]
  /// current service provider names enumarted by the [SupportedOAuthProvider] enum,
  Future<Map<dynamic, dynamic>> grantUserOAuthData(
      String userID, String providerName, String clientID, String refreshToken,
      [String accessToken]) async {
    final url = api.grantOAuth(userID).toString();
    print(url);
    final client = new http.Client();
    final response = await client.post(Uri.parse(url), headers: {
      'Authorization': '${api.apiKey}',
    }, body: {
      "provider_name": providerName,
      "client_id": clientID,
      "refresh_token": refreshToken,
    });
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(providerName);
      throw ('Request ${grantUserOAuthData(userID, providerName, clientID, refreshToken)} failed' +
          '\nResponse:${response.statusCode}\n${response.reasonPhrase}');
    }
  }

  /// Requires a [userID] and a [eventID]
  /// Adds event to user's calendar if they have granted Google OAuth permission
  Future<Map<dynamic, dynamic>> addEventToCalendar(
      String userID, String eventID) async {
    final url = api.addEventToCalendar(userID).toString();
    final client = new http.Client();
    final response = await client.post(Uri.parse(url), headers: {
      'Authorization': '${api.apiKey}',
    }, body: {
      "eventid": eventID,
    });
    if (response.statusCode == 200) {
      print('successfully added to calendar: ' + response.body);
      return jsonDecode(response.body);
    } else {
      // throw ('Request ${addEventToCalendar(userID, eventID)} failed' +
      //     '\nResponse:${response.statusCode}\n${response.reasonPhrase}'
      // );
      print('an error occured: ' + response.body);
      return jsonDecode(response.body);
    }
  }

  /// Requires a [state] integer between -1 and 2 incluive where:
  ///-1 = 'blocked users',
  /// 0 = N/A,
  /// 1 = 'pending friend requests',
  /// 2 = 'friends'
  Future<Map<dynamic, dynamic>> getUserRelationships(int state) async {
    final url = api
        .getUserUserRelationships(
            fbAuth.FirebaseAuth.instance.currentUser.uid, state.toString())
        .toString();
    final client = new http.Client();
    final response = await client.get(Uri.parse(url), headers: {
      'Authorization': '${api.apiKey}',
      'TOKEN_ID':
          '${(await fbAuth.FirebaseAuth.instance.currentUser.getIdTokenResult(true)).token}'
    });

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['relationship_list'];
      return {
        'relationship_list': data
            .map((dynamic item) => Relationship.fromJson(
                item, fbAuth.FirebaseAuth.instance.currentUser.uid))
            .toList(),
      };
    } else {
      throw ('Request ${getUserRelationships(state)} failed' +
          '\nResponse:${response.statusCode}\n${response.reasonPhrase}');
    }
  }

  /// Requires a [filePath], [userID] and [accessType]
  Future<Map<dynamic, dynamic>> uploadUserMedia(
    String filePath,
    String userID,
    String accessType,
  ) async {
    final url = api.uploadUserMedia(userID).toString();
    print(url);
    final client = new http.MultipartRequest(
      "POST",
      Uri.parse(url),
    );
    var image = await http.MultipartFile.fromPath('avatar', filePath,
        filename: filePath,
        contentType: MediaType('image', lookupMimeType(filePath)));
    client
      ..fields['access_type'] = accessType
      ..files.add(image);
    client.headers['Authorization'] = '${api.apiKey}';
    final response = await client.send();

    if (response.statusCode == 200) {
      return {'status': 'successful'};
    } else {
      throw ('Request ${String.fromCharCodes(await response.stream.toBytes())}' +
          '\nResponse:${response.statusCode}\n${response.reasonPhrase}');
    }
  }
}
