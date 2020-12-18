import 'package:flutter/material.dart';
import 'package:EventHopper/utils/constants.dart';
import 'package:EventHopper/utils/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:EventHopper/utils/screen_navigator.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Future<List<Event>> events = getEvents();

    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            VerticalSpacing(),
            VerticalSpacing(),
            ListTile(
              leading: Container(
                height: 30,
                width: 10,
              ),
              title: Text(
                'Default Location (Automatic)',
              ),
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
                ScreenNavigator.navigateLogOut(context);
              },
            ),
            // SvgPicture.asset(
            //   'assets/images/settings.svg',
            //   height: getProportionateScreenHeight(180),
            // ),
            // VerticalSpacing(),
            // VerticalSpacing(),
            // Container(
            //     width: getProportionateScreenWidth(300),
            //     child: Column(
            //       children: [
            //         Text(
            //           "COMING SOON",
            //           style: TextStyle(
            //             color: Colors.grey,
            //             fontSize: 23,
            //             fontWeight: FontWeight.normal,
            //           ),
            //         ),
            //         VerticalSpacing(),
            //         VerticalSpacing(),
            //         Text(
            //           "a",
            //           textAlign: TextAlign.center,
            //           style: TextStyle(
            //             wordSpacing: 1,
            //             fontWeight: FontWeight.normal,
            //             color: Colors.grey[350],
            //             fontSize: 18,
            //           ),
            //         ),
            //       ],
            //     )),
            // VerticalSpacing(),
            // VerticalSpacing(),
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
