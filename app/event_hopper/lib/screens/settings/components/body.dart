import 'package:EventHopper/services/eh-server/api.dart';
import 'package:EventHopper/services/oauth/spotify/spotify_oauth.dart';
import 'package:EventHopper/services/state-management/session_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:EventHopper/utils/constants.dart';
import 'package:EventHopper/utils/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:EventHopper/utils/screen_navigator.dart';
import 'package:provider/provider.dart';
import 'package:EventHopper/services/oauth/google/google_oauth.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String googleOAuthText = 'Not configured';
  String spotifyOAuthText = 'Not configured';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Future<List<Event>> events = getEvents();
    var apiMode = Provider.of<SessionManager>(context).apiMode;
    String hostDescription = 'API in-use: ' + apiMode.environment.host;

    hostDescription += apiMode.environment.port.toString() != 'null'
        ? ':' + apiMode.environment.port.toString()
        : '';
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            VerticalSpacing(),
            VerticalSpacing(),
            ListTile(
              leading: ClipOval(
                child: Image.network(
                  'https://www.pngkey.com/png/detail/128-1289947_location-pin-pin-location-gif-transparent.png',
                  height: getProportionateScreenWidth(35),
                  width: getProportionateScreenWidth(35),
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                'Default Location',
              ),
              subtitle: Text('Not set'),
              onTap: () {},
            ),
            ListTile(
              leading: ClipOval(
                child: Image.network(
                  'https://www.kylermintah.me/static/media/g-logo.fd82019e.gif',
                  height: getProportionateScreenWidth(35),
                  width: getProportionateScreenWidth(35),
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                'Connect Google Calendar (Debug)',
              ),
              subtitle: Text(googleOAuthText),
              onTap: () async {
                googleOAuthText =
                    await new GoogleOAuth().configureOAuthAccess(context);
                setState(() {});
              },
            ),
            ListTile(
              leading: ClipOval(
                child: Image.network(
                  'https://www.1pns.com/wp-content/uploads/2020/06/Spotify.gif',
                  height: getProportionateScreenWidth(35),
                  width: getProportionateScreenWidth(35),
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                'Connect Spotify (Debug)',
              ),
              subtitle: Text(spotifyOAuthText),
              onTap: () async {
                spotifyOAuthText =
                    await new SpotifyOAuth().configureOAuthAccess(context);
                setState(() {});
              },
            ),
            ListTile(
              leading: ClipOval(
                child: Image.network(
                  'https://media4.giphy.com/media/3og0Ix8tq5zyKybM9a/giphy.gif',
                  height: getProportionateScreenWidth(35),
                  width: getProportionateScreenWidth(35),
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                'Sandbox Mode',
              ),
              trailing: CupertinoSwitch(
                value: Provider.of<SessionManager>(context)
                        .apiMode
                        .environment
                        .name ==
                    API.sandbox().environment.name,
                onChanged: (value) {
                  Provider.of<SessionManager>(context, listen: false)
                      .setApiMode(value);
                },
                activeColor: Colors.deepOrangeAccent,
              ),
              subtitle: Text(hostDescription),
              onTap: () {},
            ),
            ListTile(
              leading: Container(
                height: 30,
                width: 10,
              ),
              title: Text(
                'Privacy Policy',
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Container(
                height: 30,
                width: 10,
              ),
              title: Text(
                'Log Out',
              ),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Provider.of<SessionManager>(context, listen: false).wipeState();
                ScreenNavigator.navigateLogOut(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AddNewEventCard extends StatelessWidget {
  const AddNewEventCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenWidth(350),
      width: getProportionateScreenWidth(158),
      decoration: BoxDecoration(
        color: Color(0xFF6A6C93).withOpacity(0.09),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 2,
          color: Color(0xFFEBE8F6),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: getProportionateScreenWidth(53),
            width: getProportionateScreenWidth(53),
            child: FlatButton(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60),
              ),
              color: kPrimaryColor,
              onPressed: () {},
              child: Icon(
                Icons.add,
                size: getProportionateScreenWidth(35),
                color: Colors.blue,
              ),
            ),
          ),
          VerticalSpacing(of: 10),
          Text(
            "Add New Event",
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
