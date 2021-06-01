import 'dart:ui';

import 'package:EventHopper/components/ux_approved/glass_text_field.dart';
import 'package:EventHopper/screens/route_config.dart';
import 'package:EventHopper/services/eh-server/api_service.dart';
import 'package:EventHopper/services/state-management/session_manager.dart';
import 'package:EventHopper/utils/screen_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:EventHopper/utils/size_config.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';

class FigmaBody extends StatelessWidget {
  String email;
  bool isValidUsername;
  String password;
  final _formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SingleChildScrollView(
      clipBehavior: Clip.none,
      child: Column(
        children: [
          Stack(
            overflow: Overflow.visible,
            alignment: Alignment.center,
            children: [
              Image.network(
                "https://user-images.githubusercontent.com/24496327/120110515-ceb2fd00-c13b-11eb-8d89-48c5a1f35e7d.png",
                // "https://images.unsplash.com/photo-1598649975444-0e53df8f8edd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=630&q=80",
                // "https://images.unsplash.com/photo-1507608616759-54f48f0af0ee?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
                // "https://images.unsplash.com/photo-1533174072545-7a4b6ad7a6c3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80",
                // "https://images.unsplash.com/photo-1541532713592-79a0317b6b77?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
                // "https://images.unsplash.com/photo-1539146395724-de109483bdd2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1115&q=80",
                // "https://images.unsplash.com/photo-1494668257191-e237c341e7f6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=686&q=80",
                // "https://images.unsplash.com/photo-1598450938631-cc9e7e33f28a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=701&q=80",
                // "https://images.unsplash.com/photo-1557084672-c82bc51a4e19?ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80",
                // "https://images.unsplash.com/photo-1504591504549-8ce1589ea6f6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
                fit: BoxFit.cover,
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                filterQuality: FilterQuality.low,
              ),
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.6), BlendMode.dstATop),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  color: Colors.black,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: getProportionateScreenHeight(30)),
                  Text(
                    "EventHopper",
                    style: TextStyle(
                        fontFamily: 'Proxima Nova',
                        fontSize: getProportionateScreenWidth(42),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 0.5),
                  ),
                  VerticalSpacing(
                    of: 5,
                  ),
                  Text(
                    "Experience more",
                    style: TextStyle(color: Colors.white),
                  ),
                  VerticalSpacing(),
                  VerticalSpacing(),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        GlassTextField(
                          hintText: 'USERNAME / EMAIL',
                          textListener: (value) {
                            email = value.trim();
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter email';
                            }
                            if (!isValidEmail(value) && !isValidUsername) {
                              return 'Please enter a valid username/email';
                            }
                            return null;
                          },
                          textFieldController: null,
                        ),
                        VerticalSpacing(),
                        GlassTextField(
                          hintText: 'PASSWORD',
                          obscureText: true,
                          textListener: (value) {
                            password = value.trim();
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter password';
                            }
                            if (value.length < 6) {
                              return 'Invalid login. Password must be at least 6 characters';
                            }
                            return null;
                          },
                          textFieldController: null,
                        ),
                        VerticalSpacing(),
                      ],
                    ),
                  ),
                  Center(
                    child: MaterialButton(
                      height: 45,
                      minWidth: 267,
                      color: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      child: Text(
                        "SIGN IN",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (!isValidEmail(email)) {
                          email = await eventHopperApiService.getEmail(email);
                        }
                        print("email is $email");
                        if (email != null) {
                          logInUser(context, email, password);
                        } else {
                          buildSnackbar('invalid username');
                        }
                      },
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: getProportionateScreenWidth(100),
                child: Column(
                  children: [
                    MaterialButton(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        ScreenNavigator.navigateSwipe(
                            context, RouteConfig.registration);
                      },
                    ),
                    MaterialButton(
                      child: Text(
                        "Skip (Testing purposes only)",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        ScreenNavigator.navigateSwipe(context, RouteConfig.home,
                            replace: true);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

bool isValidEmail(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
      .hasMatch(email);
}

Future<void> logInUser(
    BuildContext context, String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    if (userCredential.user != null) {
      Provider.of<SessionManager>(context, listen: false)
          .fetchCurrentUserData();
      Provider.of<SessionManager>(context, listen: false).fetchEventsNearMe();
      Provider.of<SessionManager>(context, listen: false)
          .updateInitialState(true);
      Provider.of<SessionManager>(context, listen: false).fetchUserEventLists();

      String userId = userCredential.user.uid;
      OneSignal.shared.setExternalUserId(userId);
      //successfully logged in
      ScreenNavigator.navigateSwipe(context, RouteConfig.home,
          replaceAll: true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(buildSnackbar(
          'An error occurred. Please check your internet connection'));
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      ScaffoldMessenger.of(context)
          .showSnackBar(buildSnackbar('No user found for that email.'));
    } else if (e.code == 'wrong-password') {
      ScaffoldMessenger.of(context).showSnackBar(
          buildSnackbar('Wrong password provided for that user.'));
    }
  }
}

SnackBar buildSnackbar(String text) {
  return SnackBar(
    content: Text(text),
  );
}
