import 'dart:convert';
import 'dart:developer';
import 'package:EventHopper/models/EventSpotlight.dart';
import 'package:http/http.dart' as http;
import 'package:EventHopper/services/eh-server/api.dart';

class APIService {
  final API api;
  APIService(this.api);

  Future<List<Event>> getEvents() async {
    final url = api.getEventsByCity('Philadelphia').toString();
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
      throw ('Request ${api.getEventsByCity('Philadelphia')} failed' +
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
