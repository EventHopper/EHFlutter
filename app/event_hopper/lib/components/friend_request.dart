import 'package:EventHopper/components/app_bar.dart';
import 'package:EventHopper/components/user_profile.dart';
import 'package:EventHopper/models/users/Relationship.dart';
import 'package:EventHopper/services/eh-server/api_service.dart';
import 'package:EventHopper/services/eh-server/api_wrapper.dart';
import 'package:EventHopper/services/state-management/session_manager.dart';
import 'package:EventHopper/utils/constants.dart';
import 'package:EventHopper/utils/screen_navigator.dart';
import 'package:EventHopper/utils/size_config.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class FriendRequest extends StatelessWidget {
  final Relationship relationship;
  const FriendRequest({this.relationship});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AwesomeDialog(
          context: context,
          headerAnimationLoop: false,
          customHeader: Container(
            height: 120,
            width: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image(
                fit: BoxFit.cover,
                image: null == null
                    ? NetworkImage(relationship.user.image)
                    : NetworkImage(
                            'https://post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/02/322868_1100-800x825.jpg') ??
                        CircularProgressIndicator(),
              ),
            ),
          ),
          btnOkText: 'View Profile',
          btnOkOnPress: () {
            ScreenNavigator.widget(
              context,
              new Scaffold(
                  drawer: null,
                  appBar: buildAppBar(context,
                      title: "Search",
                      color: Colors.black,
                      backButton: true,
                      profileIcon: false),
                  body: new UserProfile(this.relationship.user)),
              replace: true,
            );
          },
          btnOkColor: Colors.blueGrey,
          title: relationship.user.fullName,
          desc: '@${relationship.user.username}',
        ).show();
      },
      child: ListTile(
          leading: ClipOval(
            child: Image.network(
              relationship.user.image,
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(55),
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            relationship.user.fullName,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            '@${relationship.user.username}',
            style: TextStyle(color: Colors.black38),
          ),
          trailing: RelationshipActionButton(relationship,
              state: relationship.state,
              isRecipient: (FirebaseAuth.instance.currentUser.uid ==
                  this.relationship.recipientId))),
    );
  }
}

class RelationshipActionButton extends StatefulWidget {
  int state;
  bool isRecipient;
  Relationship relationship;
  RelationshipActionButton(this.relationship, {this.state, this.isRecipient});

  @override
  _RelationshipActionButtonState createState() =>
      _RelationshipActionButtonState();
}

class _RelationshipActionButtonState extends State<RelationshipActionButton> {
  @override
  Widget build(BuildContext context) {
    return widget.state == -5
        ? Container(
            width: 140,
            child: SpinKitCircle(
              color: kTextColor,
            ),
          )
        : widget.state == 0
            ? Container(
                width: 140,
                child: OutlineButton(
                    onPressed: () async {
                      // STUB - ask for confirmation to remove friendship
                      // STUB - send update relationships request to 1
                      //STUB - Toast Confirmation
                      setState(() {
                        widget.state = -5;
                      });
                      widget.isRecipient = false;
                      Map<dynamic, dynamic> result =
                          await EventHopperAPI.eventHopperApiService(
                                  Provider.of<SessionManager>(context).apiMode)
                              .updateUserRelationships(1, widget.relationship);
                      setState(() {
                        result['status'] == 2
                            ? executeRelationshipUpdate(1)
                            : showToast(context,
                                'Could not send friend request,\nplease try again later');
                      });
                    },
                    child: Text('send request'),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0))),
              )
            : widget.state == 1 && widget.isRecipient
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () async {
                            //STUB - send update relationships request to 2 with user token
                            //STUB - Toast Confirmation
                            setState(() {
                              widget.state = -5;
                            });
                            Map<dynamic, dynamic> result =
                                await EventHopperAPI.eventHopperApiService(
                                        Provider.of<SessionManager>(context)
                                            .apiMode)
                                    .updateUserRelationships(
                                        2, widget.relationship);
                            setState(() {
                              result['status'] == 1
                                  ? executeRelationshipUpdate(2)
                                  : showToast(context,
                                      'Could not accept friend request,\nplease try again later');
                            });
                          },
                          icon: Icon(
                            Icons.check_circle,
                            color: Colors.greenAccent[400],
                          )),
                      IconButton(
                          onPressed: () async {
                            //STUB - send update relationships request to 0 with user token
                            //STUB - Toast Confirmation

                            showConfirmationDialog(
                                context,
                                'Reject Friend Request',
                                'are you sure you would like to reject @${widget.relationship.user.username}\'s request?',
                                okCallback: () async {
                              setState(() {
                                widget.state = -5;
                              });
                              Map<dynamic, dynamic> result =
                                  await EventHopperAPI.eventHopperApiService(
                                          Provider.of<SessionManager>(context)
                                              .apiMode)
                                      .updateUserRelationships(
                                          0, widget.relationship);
                              setState(() {
                                result['status'] == 1
                                    ? executeRelationshipUpdate(0)
                                    : showToast(context,
                                        'Could not reject friend request,\nplease try again later');
                              });
                            });
                          },
                          icon: Icon(
                            Icons.cancel,
                            color: Colors.blueGrey,
                          )),
                    ],
                  )
                : widget.state == 1 && !widget.isRecipient
                    ? Container(
                        width: 100,
                        child: OutlineButton(
                            onPressed: () async {
                              // STUB - ask for confirmation to withdraw friendship request
                              // STUB - send update relationships request to 0
                              //STUB - Toast Confirmation
                              showConfirmationDialog(
                                  context,
                                  'Withdraw Friend Request',
                                  'are you sure you would like to withdraw your friend request to @${widget.relationship.user.username}?',
                                  okCallback: () async {
                                setState(() {
                                  widget.state = -5;
                                });
                                Map<dynamic, dynamic> result =
                                    await EventHopperAPI.eventHopperApiService(
                                            Provider.of<SessionManager>(context)
                                                .apiMode)
                                        .updateUserRelationships(
                                            0, widget.relationship);
                                setState(() {
                                  result['status'] == 2
                                      ? executeRelationshipUpdate(0)
                                      : showToast(context,
                                          'Could not reject friend request,\nplease try again later');
                                });
                              });
                            },
                            child: Text('pending'),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0))),
                      )
                    : widget.state == 2
                        ? Container(
                            width: 95,
                            child: FlatButton(
                                color: Colors.blue,
                                onPressed: () {
                                  showConfirmationDialog(context, 'Unfriend',
                                      'are you sure you would like to unfriend\n${widget.relationship.user.fullName}?',
                                      okCallback: () async {
                                    setState(() {
                                      widget.state = -5;
                                    });
                                    Map<dynamic, dynamic> result =
                                        await EventHopperAPI
                                                .eventHopperApiService(
                                                    Provider.of<SessionManager>(
                                                            context)
                                                        .apiMode)
                                            .updateUserRelationships(
                                                0, widget.relationship);
                                    setState(() {
                                      result['status'] == 2
                                          ? executeRelationshipUpdate(0,
                                              message:
                                                  'Unfriended ${widget.relationship.user.fullName}')
                                          : showToast(context,
                                              'Could not accept friend request,\nplease try again later');
                                    });
                                  });
                                },
                                child: Text(
                                  'friends',
                                  style: TextStyle(color: Colors.white),
                                ),
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0))),
                          )
                        : null;
  }

  void executeRelationshipUpdate(int state, {String message}) {
    widget.state = state;
    if (message == null) {
      switch (state) {
        case -1:
          showToast(context, 'User Successfully Blocked ⛔');
          break;
        case 0:
          showToast(context, 'Friend Request Removed 📪');
          break;
        case 1:
          showToast(context, 'Friend Request Sent! 📫');
          break;
        case 2:
          showToast(context, 'Friend Request Accepted 🎉');
          break;
        default:
          break;
      }
    } else {
      showToast(context, message);
    }
  }
}

void showToast(BuildContext context, String message) {
  Toast.show(message, context,
      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
}

Relationship ensureCorrectRequestor(
    Relationship relationship, String requesterID, String recipientId) {
  relationship..requesterId = requesterID;
  relationship..recipientId = recipientId;
  return relationship;
}

void showConfirmationDialog(BuildContext context, String title, String message,
    {Function okCallback, Function cancelCallback}) {
  AwesomeDialog(
    context: context,
    headerAnimationLoop: false,
    isDense: true,
    btnOkText: 'Confirm',
    btnOkOnPress: okCallback,
    btnCancelColor: Colors.blueGrey,
    btnCancelText: 'Cancel',
    btnCancelOnPress: cancelCallback,
    btnOkColor: Colors.blueGrey,
    title: title,
    desc: message,
  ).show();
}
