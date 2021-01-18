import 'dart:io';

import 'package:EventHopper/services/config.dart';
import 'package:EventHopper/services/oauth/oauth_services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:googleapis/calendar/v3.dart';

class SpotifyOAuth {
  var _scopes = const [];

  Future<String> configureOAuthAccess() async {
    var _credentials;
    var _authorizationEndpoint = SpotifyOAuthConfig.authorizationEndpoint;
    var _tokenEndpoint = SpotifyOAuthConfig.tokenEndpoint;
    if (Platform.isAndroid) {
      _credentials = _credentials = SpotifyOAuthConfig.clientIdAndroid;
    } else if (Platform.isIOS) {
      _credentials = SpotifyOAuthConfig.clientIdIOS;
    }

    AuthorizationTokenResponse auth = await runOAuth(
        _credentials, _authorizationEndpoint, _tokenEndpoint, _scopes);
    //TODO: Send token response to server
    return auth.refreshToken;
  }
}
