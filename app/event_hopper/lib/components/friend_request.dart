import 'package:EventHopper/models/users/Relationship.dart';
import 'package:EventHopper/utils/size_config.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
          btnOkOnPress: () {},
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
          trailing: RelationshipActionButton(
              state: relationship.state,
              isRecipient: (FirebaseAuth.instance.currentUser.uid ==
                  this.relationship.recipientId))),
    );
  }
}

class RelationshipActionButton extends StatelessWidget {
  final int state;
  final bool isRecipient;
  const RelationshipActionButton({this.state, this.isRecipient});
  @override
  Widget build(BuildContext context) {
    return state == 1 && isRecipient
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.check_circle,
                    color: Colors.greenAccent[400],
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.blueGrey,
                  )),
            ],
          )
        : state == 1 && !isRecipient
            ? Container(
                width: 100,
                child: OutlineButton(
                    onPressed: () {},
                    child: Text('pending'),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0))),
              )
            : state == 2
                ? Container(
                    width: 95,
                    child: OutlineButton(
                        onPressed: () {},
                        child: Text('friends'),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0))),
                  )
                : null;
  }
}
