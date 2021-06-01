import 'package:EventHopper/services/state-management/session_manager.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter/material.dart';
import 'package:EventHopper/utils/screen_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../../route_config.dart';

class Body extends StatefulWidget {
  Body({Key key, this.title}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
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

  final emailFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    emailFieldController.dispose();
    passwordFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: widget._formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Material(
              child: TextFormField(
                style: style,
                decoration: buildInputDecoration("email"),
                controller: emailFieldController,
                keyboardType: TextInputType.emailAddress,
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
            ),
            SizedBox(
              height: 15.0,
            ),
            TextFormField(
              obscureText: true,
              style: style,
              decoration: buildInputDecoration("Password"),
              controller: passwordFieldController,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter password';
                }
                if (value.length < 6) {
                  return 'Invalid login. Password must be at least 6 characters';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () async {
                  if (widget._formKey.currentState.validate()) {
                    // If the form is valid, send post request to firebase.
                    logInUser();
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

  InputDecoration buildInputDecoration(String hinttext) {
    return InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: hinttext,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)));
  }

  SnackBar buildSnackbar(String text) {
    return SnackBar(
      content: Text(text),
    );
  }

  Future<void> logInUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailFieldController.text.trim(),
              password: passwordFieldController.text.trim());

      if (userCredential.user != null) {
        Provider.of<SessionManager>(context, listen: false)
            .fetchCurrentUserData();
        Provider.of<SessionManager>(context, listen: false).fetchEventsNearMe();
        Provider.of<SessionManager>(context, listen: false)
            .updateInitialState(true);
        Provider.of<SessionManager>(context, listen: false)
            .fetchUserEventLists();

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

  bool isValidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(email);
  }
}
