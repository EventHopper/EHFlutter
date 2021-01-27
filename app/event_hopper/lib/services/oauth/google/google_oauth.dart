import 'dart:io';

import 'package:EventHopper/services/config.dart';
import 'package:EventHopper/services/eh-server/api_service.dart';
import 'package:EventHopper/services/oauth/oauth_services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:googleapis/calendar/v3.dart';

class GoogleOAuth {
  var _scopes = const [
    CalendarApi.CalendarScope,
    CalendarApi.CalendarEventsScope,
  ];

  Future<String> configureOAuthAccess() async {
    var _clientID;
    var _authorizationEndpoint = GoogleOAuthConfig.authorizationEndpoint;
    var _tokenEndpoint = GoogleOAuthConfig.tokenEndpoint;
    if (Platform.isAndroid) {
      _clientID = _clientID = GoogleOAuthConfig.clientIdAndroid;
    } else if (Platform.isIOS) {
      _clientID = GoogleOAuthConfig.clientIdIOS;
    }

    AuthorizationTokenResponse auth = await runOAuth(
        _clientID, _authorizationEndpoint, _tokenEndpoint, _scopes);
    apiService.storeUserOAuthData(
        GoogleOAuthConfig.providerName, _clientID, auth.refreshToken);
    return auth.refreshToken;
  }
}
