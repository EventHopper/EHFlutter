import 'package:EventHopper/services/eh-server/api_service.dart';
import 'package:EventHopper/services/eh-server/api_wrapper.dart';
import 'package:EventHopper/services/state-management/session_manager.dart';
import 'package:EventHopper/utils/screen_navigator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../../route_config.dart';

class Body extends StatefulWidget {
  Body({Key key, this.title}) : super(key: key);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final _formKey = GlobalKey<FormState>();

  final emailFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();
  final nameFieldController = TextEditingController();
  final usernameFieldController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    emailFieldController.dispose();
    passwordFieldController.dispose();
    nameFieldController.dispose();
    usernameFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              style: style,
              controller: nameFieldController,
              decoration: buildInputDecoration("Name (Optional)"),
              validator: (value) {
                return null;
              },
            ),
            SizedBox(height: 25.0),
            TextFormField(
              style: style,
              decoration: buildInputDecoration("username"),
              controller: usernameFieldController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter username';
                }
                if (!isValidUsername(value)) {
                  return 'Username cannot contain special characters';
                }
                return null;
              },
            ),
            SizedBox(height: 45.0),
            TextFormField(
              style: style,
              decoration: buildInputDecoration("email"),
              controller: emailFieldController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter email';
                }
                if (!isValidEmail(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            SizedBox(height: 45.0),
            TextFormField(
              obscureText: true,
              style: style,
              decoration: buildInputDecoration("Password"),
              controller: passwordFieldController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () async {
                  // Validate returns true if the form is valid, or false
                  // otherwise.
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, send post request to firebase.
                    dynamic responseBody;
                    try {
                      responseBody = await EventHopperAPI.eventHopperApiService(
                              Provider.of<SessionManager>(context).apiMode)
                          .registerUser(
                              email: emailFieldController.text,
                              fullName: nameFieldController.text,
                              password: passwordFieldController.text,
                              username: usernameFieldController.text);
                    } catch (e) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Something went wrong, please check your network connection'),
                        ),
                      );
                    }

                    if (responseBody['code'] == 10) {
                      loginUser();
                      ScreenNavigator.navigateSwipe(context, RouteConfig.home);
                    } else {
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text(responseBody['message'])));
                    }
                  }
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailFieldController.text,
              password: passwordFieldController.text);

      if (userCredential.user != null) {
        //successfully logged in
        ScreenNavigator.navigateSwipe(context, RouteConfig.home);
      } else {
        Scaffold.of(context).showSnackBar(buildSnackbar(
            'An error occurred. Please check your internet connection'));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Scaffold.of(context)
            .showSnackBar(buildSnackbar('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        Scaffold.of(context).showSnackBar(
            buildSnackbar('Wrong password provided for that user.'));
      }
    }
  }

  SnackBar buildSnackbar(String text) {
    return SnackBar(
      content: Text(text),
    );
  }

  InputDecoration buildInputDecoration(String hinttext) {
    return InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: hinttext,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)));
  }

  bool isValidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(email);
  }

  bool isValidUsername(String username) {
    return RegExp(r"^(?!.*\.\.)(?!.*\.$)[^\W][\w.]{0,29}$").hasMatch(username);
  }
}
