import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import "package:googleapis_auth/auth_io.dart";
import 'package:googleapis/calendar/v3.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'oauth_services.dart';

class GoogleOAuth {
  var _scopes = const [
    CalendarApi.CalendarScope,
    CalendarApi.CalendarEventsScope,
    // 'https://www.googleapis.com/auth/userinfo.email',
    // 'https://www.googleapis.com/auth/calendar.app.created',
    // 'https://www.googleapis.com/auth/calendar.freebusy',
    // 'https://www.googleapis.com/auth/calendar.events.freebusy',
    // 'https://www.googleapis.com/auth/calendar'
  ];

  Future<String> configureOAuthAccess() async {
    var _credentials;
    if (Platform.isAndroid) {
      _credentials =
          "500810512979-15dhf9bu54e993s18utn24606grjui54.apps.googleusercontent.com";
      // "500810512979-i48elii1l3dr2sloa89d997glojfb0vl.apps.googleusercontent.com"; // Web
    } else if (Platform.isIOS) {
      _credentials =
          "500810512979-6e7c9g4h8co6416i0bbfihokptksl05o.apps.googleusercontent.com";
    }

    AuthorizationTokenResponse auth =
        // await _handleSignIn(_credentials, _scopes);
        await runOAuth(_credentials, _scopes);
    print('The refresh_token ${auth.refreshToken}');
    print('The id_token ${auth.idToken}');
    print('The token_type ${auth.tokenType}');
    print('The access_token ${auth.accessToken}');
    print(
        'The additional parameters ${auth.authorizationAdditionalParameters}');
    //TODO: Send token response to server
    return auth.refreshToken;
  }

  /// Method 1
  /// Drawbacks - does not return refresh
  Future<GoogleSignInAuthentication> _handleSignIn(
      String credentials, List<String> scopes) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      clientId: credentials,
      scopes: scopes,
    );
    print(_googleSignIn);
    try {
      await _googleSignIn.signIn().then((value) async {
        return (await value.authentication);
      });
    } catch (error) {
      print(error);
    }
    return null;
  }
}
