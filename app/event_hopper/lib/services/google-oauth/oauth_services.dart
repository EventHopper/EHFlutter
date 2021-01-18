import 'package:EventHopper/utils/system_utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:crypto/crypto.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uni_links/uni_links.dart';

import 'package:oauth2/oauth2.dart' as oauth2;

Uri oauth() => Uri(
      host: 'oauth2.googleapis.com',
      path: '/users/register',
    );

/// Method 2
/// WIP
Future<dynamic> runOAuth1s() async {
  final url = oauth().toString();
  print(url);
  final client = new http.Client();
  final response = await client.post(Uri.parse(url), headers: {
    'Content-Type': 'application/x-www-form-urlencoded'
  }, body: {
    "code": '',
    "client_id": '',
    "redirect_uri": "urn:ietf:wg:oauth:2.0:oob",
    "grant_type": "authorization_code"
  });
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw ('Request failed' +
        '\nResponse:${response.statusCode}\n${response.reasonPhrase}');
  }
}

Future<dynamic> runOAuth(String clientId, List<String> scopes) async {
  FlutterAppAuth appAuth = FlutterAppAuth();
  // appAuth.authorize(AuthorizationRequest(
  //   clientId,
  //   "http://localhost",
  //   scopes: scopes,
  //   issuer: 'https://accounts.google.com/o/oauth2/auth',
  // ));

  // final String _clientId = 'interactive.public';
  // final String _redirectUrl = 'urn:ietf:wg:oauth:2.0:oob';
  // final String _issuer = 'https://accounts.google.com/o/oauth2/auth';
  // final String _discoveryUrl =
  //     'https://demo.identityserver.io/.well-known/openid-configuration';

  String code = getRandomString(128);
  var hash = sha256.convert(ascii.encode(code));
  String codeChallenge = base64Url
      .encode(hash.bytes)
      .replaceAll("=", "")
      .replaceAll("+", "-")
      .replaceAll("/", "_");

  // final AuthorizationTokenResponse result =
  //     await appAuth.authorizeAndExchangeCode(
  //   AuthorizationTokenRequest(
  //     clientId,
  //     "http://127.0.0.1",
  //     issuer: 'https://accounts.google.com/o/oauth2/auth',
  //     scopes: scopes,
  //   ),
  // );

  // final TokenResponse tokenResult = await appAuth.token(TokenRequest(
  //     clientId, "http://127.0.0.1:3000",
  ///    urn:ietf:wg:oauth:2.0:oob:auto
  //     codeVerifier: codeChallenge,
  //     scopes: ['openid', 'profile', 'email', 'offline_access', 'api']));
  // const String AUTH_REDIRECT_URI =
  //     'urn:ietf:wg:oauth:2.0:oob://com.eventhopper.app:/oauth2callback';
  print('The auth token is not yet defined. FETCHING NOW');
  final AuthorizationTokenResponse result = await appAuth
      .authorizeAndExchangeCode(
        AuthorizationTokenRequest(
            clientId, 'com.eventhopper.app:/oauth2redirect',
            serviceConfiguration: AuthorizationServiceConfiguration(
              "https://accounts.google.com/o/oauth2/auth",
              "https://oauth2.googleapis.com/token",
            ),
            scopes: scopes),
      )
      .catchError((onError) => print('The error was $onError'));

  return result;
}

// String spotifyExample = Uri.parse(
//         "https://accounts.spotify.com/authorize?response_type=code&client_id=${clientId}&redirect_uri=http%3A%2F%2Flocalhost%2Fauth&scope=user-top-read&code_challenge=$codeChallenge&code_challenge_method=S256")
//     .toString();

dynamic runOAuth2(String clientId, List<String> scopes) {
  final authorizationEndpoint =
      Uri.parse('https://accounts.google.com/o/oauth2/auth');
  final tokenEndpoint = Uri.parse('https://oauth2.googleapis.com/token');
  final identifier = clientId;
  // final secret = 'my client secret';
  final redirectUrl = Uri.parse('com.eventhopper.app:/oauth2redirect');

  Future<oauth2.Client> createClient() async {
    // If we don't have OAuth2 credentials yet, we need to get the resource owner
    // to authorize us. We're assuming here that we're a command-line application.
    var grant = oauth2.AuthorizationCodeGrant(
      identifier,
      authorizationEndpoint,
      tokenEndpoint,
    );

    // A URL on the authorization server (authorizationEndpoint with some additional
    // query parameters). Scopes and state can optionally be passed into this method.
    var authorizationUrl =
        grant.getAuthorizationUrl(redirectUrl, scopes: scopes);

    // Redirect the resource owner to the authorization URL. Once the resource
    // owner has authorized, they'll be redirected to `redirectUrl` with an
    // authorization code. The `redirect` should cause the browser to redirect to
    // another URL which should also have a listener.
    //
    // `redirect` and `listen` are not shown implemented here. See below for the
    // details.
    await redirect(authorizationUrl.toString());
    Uri responseUrl = await listen(redirectUrl.toString());
    print('THIS IS THE RESPONSE URL: $responseUrl');
    // Once the user is redirected to `redirectUrl`, pass the query parameters to
    // the AuthorizationCodeGrant. It will validate them and extract the
    // authorization code to create a new Client.
    return await grant.handleAuthorizationResponse(responseUrl.queryParameters);
  }

  print(createClient());
}

Future<dynamic> redirect(String authorizationUrl) async {
  if (await canLaunch(authorizationUrl.toString())) {
    await launch(authorizationUrl.toString());
  }
}

Future<dynamic> listen(String redirectUrl) async {
  var responseUrl;
  getLinksStream().listen((String uri) async {
    if (uri.startsWith(redirectUrl)) {
      responseUrl = uri;
    }
  });
  return responseUrl;
}
