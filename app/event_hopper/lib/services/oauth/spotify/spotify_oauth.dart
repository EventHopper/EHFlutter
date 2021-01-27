import 'dart:io';

import 'package:EventHopper/services/config.dart';
import 'package:EventHopper/services/oauth/oauth_services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:EventHopper/services/eh-server/api_service.dart';

class SpotifyOAuth {
  var _scopes = const [];

  Future<String> configureOAuthAccess() async {
    String _clientID;
    String _authorizationEndpoint = SpotifyOAuthConfig.authorizationEndpoint;
    String _tokenEndpoint = SpotifyOAuthConfig.tokenEndpoint;
    if (Platform.isAndroid) {
      _clientID = _clientID = SpotifyOAuthConfig.clientIdAndroid;
    } else if (Platform.isIOS) {
      _clientID = SpotifyOAuthConfig.clientIdIOS;
    }

    AuthorizationTokenResponse auth = await runOAuth(
        _clientID, _authorizationEndpoint, _tokenEndpoint, _scopes);
    apiService.storeUserOAuthData(
        SpotifyOAuthConfig.providerName, _clientID, auth.refreshToken);
    return auth.refreshToken;
  }
}
