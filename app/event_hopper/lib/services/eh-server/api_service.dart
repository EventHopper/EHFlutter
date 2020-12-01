import 'dart:convert';
import 'dart:developer';
import 'package:EventHopper/models/events/Event.dart';
import 'package:http/http.dart' as http;
import 'package:EventHopper/services/eh-server/api.dart';

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

  // Future<int> getEndpointData(
  //     {@required String accessToken, @required Endpoint endpoint}) async {
  //   final uri = api.endpintUri(endpoint);
  //   final response = await http
  //       .get(uri.toString(), headers: {'Authorization': '${api.apiKey}'});

  //   if (response.statusCode == 200) {
  //     final List<dynamic> data = json.decode(response.body);
  //     if (data.isNotEmpty) {
  //       final Map<String, dynamic> endpointData = data[0];
  //       final String responseJsonKey = _responseJsonKeys[endpoint];
  //       final int result = endpointData[responseJsonKey];
  //       if (result != null) {
  //         return result;
  //       }
  //     }
  //   }
  // }

  static Map<Endpoint, String> _responseJsonKeys = {Endpoint.events: 'name'};
}
