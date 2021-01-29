import 'package:EventHopper/services/services-config.dart';
import 'package:EventHopper/services/oauth/oauth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:EventHopper/services/eh-server/api_service.dart';

class SpotifyOAuth {
  var config = new SpotifyOAuthConfig();
  Future<String> configureOAuthAccess() async {
    SupportedOAuthProvider _providerName = config.providerName;
    String _clientID = config.clientId;
    String _authorizationEndpoint = config.authorizationEndpoint;
    String _tokenEndpoint = config.tokenEndpoint;
    String _redirectURL = config.redirectURL;
    List<String> _scopes = config.scopes;

    AuthorizationTokenResponse auth = await runOAuth(_clientID,
        _authorizationEndpoint, _tokenEndpoint, _redirectURL, _scopes);
    eventHopperApiService.grantUserOAuthData(
        FirebaseAuth.instance.currentUser.uid,
        _providerName.toString().split('.').last,
        _clientID,
        auth.refreshToken);

    return 'You have successfully granted EventHopper OAuth Access to your Spotify account';
  }
}
