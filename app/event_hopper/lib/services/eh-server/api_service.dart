import 'dart:convert';
import 'dart:developer';
import 'package:EventHopper/models/events/Event.dart';
import 'package:http/http.dart' as http;
import 'package:EventHopper/services/eh-server/api.dart';
import 'package:firebase_auth/firebase_auth.dart';

final apiService = APIService(API.sandbox());

class APIService {
  final API api;
  APIService(this.api);

  Future<List<Event>> getEventsByCity(String city,
      {List<String> categories,
      DateTime dateAfter,
      DateTime dateBefore,
      int page}) async {
    final url = api
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
      throw ('Request ${api.getEventsByCity(city, page: 2, dateAfter: DateTime.parse('2021-08-10T00:00:00.000Z'))} failed' +
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
      'Authorization': '${api.apiKey}'
    }, body: {
      "username": username,
      "password": password,
      "email": email,
      "full_name": fullName
    });
    if (response.statusCode == 200) {
      jsonDecode(response.body);
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
    String userId = FirebaseAuth.instance.currentUser.uid;
    final url = api.swipeEntry(userId).toString();
    print(url);
    final client = new http.Client();
    final response = await client.post(Uri.parse(url), headers: {
      'Authorization': '${api.apiKey}'
    }, body: {
      "$direction": "$eventId",
    });
    if (response.statusCode == 200) {
      jsonDecode(response.body);
      return jsonDecode(response.body);
    } else {
      throw ('Request ${api.registerUser()} failed' +
          '\nResponse:${response.statusCode}\n${response.reasonPhrase}');
    }
  }
}
