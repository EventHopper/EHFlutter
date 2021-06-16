import 'package:EventHopper/services/eh-server/api_service.dart';

// ignore: must_be_immutable
class EventHopperAPI {
  APIService apiService;

  static APIService eventHopperApiService(apiMode) => new APIService(apiMode);
}
