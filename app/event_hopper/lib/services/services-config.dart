import 'package:flutter_dotenv/flutter_dotenv.dart';

/// This file is only functional when used in conjunction with the
/// [flutter_dotenv](https://pub.dev/packages/flutter_dotenv) package. Follow
/// the link for instructions in configuring your .env file in assets directory.

enum Environment { LOCAL, SANDBOX, PRODUCTION, NONE }

abstract class APIEnvironmentConfig {
  Environment get name => Environment.NONE;
  String get key => null;
  String get host => null;
  int get port => null;
}

class LocalEnvironment implements APIEnvironmentConfig {
  @override
  Environment get name => Environment.LOCAL;
  @override
  String get key => env['EHKEY_LOCAL'];
  @override
  String get host => env['LOCAL_HOST'];
  @override
  int get port => int.parse(env['LOCAL_PORT']);
}

class SandboxEnvironment implements APIEnvironmentConfig {
  @override
  Environment get name => Environment.SANDBOX;
  @override
  String get key => env['EHKEY_SANDBOX'];
  @override
  String get host => env['SANDBOX_HOST'];
  @override
  int get port => int.parse(env['SANDBOX_PORT']);
}

class ProductionEnvironment implements APIEnvironmentConfig {
  @override
  Environment get name => Environment.PRODUCTION;
  @override
  String get key => env['EHKEY_PRODUCTION'];
  @override
  String get host => env['PRODUCTION_HOST'];
  @override
  int get port => null;
}

/// Extend this class to add additional OAuth Providers
abstract class OAuthConfig {
  String get redirectURL => 'com.eventhopper.app:/oauth2redirect';
  List<String> get scopes => const [];
  SupportedOAuthProvider get providerName => throw UnsupportedError('');
  String get clientId => throw UnsupportedError('');
  String get clientSecret => throw UnsupportedError('');
  String get clientIdAndroid => clientId;
  String get clientIdIOS => clientId;
  String get clientIdWeb => clientId;
  String get authorizationEndpoint;
  String get tokenEndpoint;
}

enum SupportedOAuthProvider {
  GOOGLE,
  SPOTIFY,
}

/// Reference our Google Cloud Project Console for config details.
///
/// See [Google API documentation](https://developers.google.com/identity/protocols/oauth2)
/// for implementation & client details
class GoogleOAuthConfig extends OAuthConfig {
  @override
  SupportedOAuthProvider get providerName => SupportedOAuthProvider.GOOGLE;

  /// [See Google API Scopes](https://developer.spotify.com/documentation/general/guides/scopes/)
  /// for reference
  @override
  List<String> get scopes => const [
        'https://www.googleapis.com/auth/calendar',
        'https://www.googleapis.com/auth/calendar.events',
      ];

  @override
  String get clientId =>
      throw UnsupportedError('Oauth provder does not accept single client ID');

  @override
  String get clientIdAndroid => env['GOOGLE_ANDROID_CLIENT_ID'];
  @override
  String get clientIdIOS => env['GOOGLE_IOS_CLIENT_ID'];
  @override
  String get clientIdWeb => env['GOOGLE_WEB_CLIENT_ID'];
  @override
  String get authorizationEndpoint =>
      'https://accounts.google.com/o/oauth2/auth';

  @override
  String get tokenEndpoint => 'https://oauth2.googleapis.com/token';
}

/// Reference our Spotify SDA for config details.
///
/// See [Spotify documentation](https://developer.spotify.com/documentation/general/guides/authorization-guide/)
/// for implementation & grant flow details
class SpotifyOAuthConfig extends OAuthConfig {
  @override
  SupportedOAuthProvider get providerName => SupportedOAuthProvider.SPOTIFY;

  /// [See Spotify API Scopes](https://developer.spotify.com/documentation/general/guides/scopes/)
  /// for reference
  @override
  List<String> get scopes => const ['user-top-read'];

  @override
  String get clientId => env['SPOTIFY_CLIENT_ID'];

  @override
  String get clientSecret => env['SPOTIFY_CLIENT_SECRET'];

  @override
  String get authorizationEndpoint => 'https://accounts.spotify.com/authorize';

  @override
  String get tokenEndpoint => 'https://accounts.spotify.com/api/token';
}

/// TODO: Add Pandora OAuth to supported providers via documentation:
/// https://developer.pandora.com/docs/tutorials/authenticate-app-user-pandora/
