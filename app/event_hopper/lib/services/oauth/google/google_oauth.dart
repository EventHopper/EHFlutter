import 'dart:io';

import 'package:EventHopper/services/services-config.dart';
import 'package:EventHopper/services/eh-server/api_service.dart';
import 'package:EventHopper/services/oauth/oauth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_appauth/flutter_appauth.dart';

class GoogleOAuth {
  var config = new GoogleOAuthConfig();
  Future<String> configureOAuthAccess() async {
    SupportedOAuthProvider _providerName = config.providerName;
    String _clientID;
    String _authorizationEndpoint = config.authorizationEndpoint;
    String _tokenEndpoint = config.tokenEndpoint;
    String _redirectURL = config.redirectURL;
    List<String> _scopes = config.scopes;
    if (Platform.isAndroid) {
      _clientID = _clientID = config.clientIdAndroid;
    } else if (Platform.isIOS) {
      _clientID = config.clientIdIOS;
    }

    AuthorizationTokenResponse auth = await runOAuth(_clientID,
        _authorizationEndpoint, _tokenEndpoint, _redirectURL, _scopes);
    eventHopperApiService.grantUserOAuthData(
        FirebaseAuth.instance.currentUser.uid,
        _providerName.toString().split('.').last,
        _clientID,
        auth.refreshToken);

    return 'You have successfully granted EventHopper OAuth Access to your Google account';
  }
}
