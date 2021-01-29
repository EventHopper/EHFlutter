import 'package:EventHopper/utils/system_utils.dart';
import 'dart:convert';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:crypto/crypto.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uni_links/uni_links.dart';

Future<dynamic> runOAuth(String clientId, String authorizationEndpoint,
    String tokenEndpoint, String redirectURL, List<String> scopes) async {
  FlutterAppAuth appAuth = FlutterAppAuth();

  String code = getRandomString(128);
  var hash = sha256.convert(ascii.encode(code));
  String codeChallenge = base64Url
      .encode(hash.bytes)
      .replaceAll("=", "")
      .replaceAll("+", "-")
      .replaceAll("/", "_");

  print('The auth token is not yet defined. FETCHING NOW');
  final AuthorizationTokenResponse result = await appAuth
      .authorizeAndExchangeCode(
        AuthorizationTokenRequest(clientId, redirectURL,
            serviceConfiguration: AuthorizationServiceConfiguration(
              authorizationEndpoint,
              tokenEndpoint,
            ),
            scopes: scopes),
      )
      .catchError((onError) => print('The error was $onError'));

  return result;
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
