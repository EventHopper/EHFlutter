import 'package:EventHopper/components/friend_request.dart';
import 'package:EventHopper/models/users/Relationship.dart';
import 'package:EventHopper/models/users/User.dart';
import 'package:EventHopper/services/eh-server/api_service.dart';
import 'package:EventHopper/services/state-management/session_manager.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:flutter/material.dart';
import 'package:EventHopper/utils/constants.dart';
import 'package:EventHopper/utils/size_config.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  final User userToDisplay;
  UserProfile(this.userToDisplay);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Future<Relationship> relationship;
  @override
  void initState() {
    fetchOtherUserData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User userToDisplay = widget.userToDisplay;
    return Consumer<SessionManager>(
      builder: (BuildContext context, SessionManager sessionManager,
              Widget widget) =>
          FutureBuilder<Map<String, dynamic>>(
        future: sessionManager.otherUserProfileView,
        builder: (context, fetchedUserData) => Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                VerticalSpacing(),
                Container(
                    width: getProportionateScreenWidth(400),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 50,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30)),
                              height: 135,
                              width: 120,
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 7,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Container(
                                        height: 120,
                                        width: 120,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: Image(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                userToDisplay.image),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Consumer<SessionManager>(
                              builder: (BuildContext context,
                                      SessionManager sessionManager,
                                      Widget widget) =>
                                  FutureBuilder<Map<String, dynamic>>(
                                future: sessionManager.otherUserProfileView,
                                builder: (context, fetchedUserData) =>
                                    fetchedUserData.hasData &&
                                            fetchedUserData.connectionState ==
                                                ConnectionState.done
                                        ? UserDetails(
                                            userToDisplay:
                                                fetchedUserData.data['user'],
                                            relationshipWithLoggedInUser:
                                                fetchedUserData
                                                    .data['relationship'],
                                          )
                                        : UserDetails(
                                            userToDisplay: userToDisplay,
                                            relationshipWithLoggedInUser: null),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
                VerticalSpacing(),
                VerticalSpacing(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void fetchOtherUserData(BuildContext context) {
    Provider.of<SessionManager>(context, listen: false)
        .fetchOtherUserProfileViewData(widget.userToDisplay.username);
  }
}

class UserDetails extends StatelessWidget {
  const UserDetails({
    Key key,
    @required this.userToDisplay,
    this.relationshipWithLoggedInUser,
  }) : super(key: key);

  final User userToDisplay;
  final Relationship relationshipWithLoggedInUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          userToDisplay.fullName,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 22,
            color: const Color(0xff29c0ff),
            letterSpacing: 0.209,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ),
        Text(
          '@${userToDisplay.username}',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 14,
            color: const Color(0xff666666),
            letterSpacing: 0.126,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ),
        relationshipWithLoggedInUser != null
            ? RelationshipStatus(relationship: relationshipWithLoggedInUser)
            : SpinKitThreeBounce(
                color: Colors.lightBlue,
              )
      ],
    );
  }
}

class RelationshipStatus extends StatelessWidget {
  Relationship relationship;
  String loggedInUserID;
  RelationshipStatus({this.relationship});

  @override
  Widget build(BuildContext context) {
    loggedInUserID = fbAuth.FirebaseAuth.instance.currentUser.uid;
    if (relationship == null) {
      relationship = Relationship.noRelation();
    }
    return RelationshipActionButton(relationship,
        state: this.relationship.state,
        isRecipient: (loggedInUserID == this.relationship.recipientId));
  }
}
