import 'dart:async';

import 'package:EventHopper/components/friend_request.dart';
import 'package:EventHopper/models/users/Relationship.dart';
import 'package:EventHopper/models/users/User.dart';
import 'package:EventHopper/screens/friends/components/no_friends.dart';
import 'package:EventHopper/services/state-management/session_manager.dart';
import 'package:EventHopper/utils/system_utils.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:EventHopper/utils/constants.dart';
import 'package:EventHopper/utils/size_config.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:EventHopper/services/eh-server/api_service.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String query = '';
  List<User> userList;
  StreamController<List<User>> _searchController;

  @override
  void initState() {
    _searchController = new StreamController();
    userList = <User>[];
    _searchController.add(userList);

    super.initState();
  }

  Timer searchOnStoppedTyping;

  _onChangeHandler(value) {
    const duration = Duration(
        milliseconds:
            200); // set the duration that you want call search() after that.
    if (searchOnStoppedTyping != null) {
      searchOnStoppedTyping.cancel(); // clear timer
    }

    searchOnStoppedTyping = new Timer(duration, () {
      setState(() {
        query = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VerticalSpacing(of: 30),
        Hero(
          tag: 'thisIsATestTag',
          child: Material(
            child: Container(
              width: getProportionateScreenWidth(313),
              height: getProportionateScreenWidth(50),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Color(0xFF3E4067),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(3, 3),
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.16),
                    spreadRadius: -2,
                  )
                ],
              ),
              child: TextField(
                textInputAction: TextInputAction.search,
                autocorrect: false,
                autofocus: true,
                onEditingComplete: () {
                  FocusManager.instance.primaryFocus.unfocus();
                  searchOnStoppedTyping.cancel();
                },
                onChanged: (value) async {
                  _onChangeHandler(value);
                },
                decoration: InputDecoration(
                  hintText: "Search EventHopper…",
                  hintStyle: TextStyle(
                    fontSize: getProportionateScreenWidth(12),
                    color: Color(0xFF464A7E),
                  ),
                  suffixIcon: Icon(Icons.search),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                    vertical: getProportionateScreenWidth(10),
                  ),
                ),
              ),
            ),
          ),
        ),
        VerticalSpacing(of: 30),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(5),
            child: StreamBuilder<List<User>>(
                stream: eventHopperApiService.searchUsers(query).asStream(),
                builder: (BuildContext context, users) {
                  if (!users.hasData ||
                      users.connectionState == ConnectionState.waiting) {
                    return users.data == null &&
                            users.connectionState == ConnectionState.done
                        ? ListView(children: [
                            VerticalSpacing(of: 40),
                            Column(
                              children: [
                                Text(
                                  'No Results Found for "$query"',
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ],
                            )
                          ])
                        : Container(
                            height: getProportionateScreenHeight(600),
                            child: SpinKitChasingDots(
                              color: kTextColor,
                              size: 50.0,
                            ),
                          );
                  } else if (users.hasData) {
                    List<User> recievedUsers = users.data;

                    if (recievedUsers.length < 1) {
                      return NoFriendsMessage();
                    }
                    // print(recievedUsers);
                    return ListView.builder(
                      itemCount: recievedUsers.length,
                      itemBuilder: (BuildContext context, int index) {
                        return new UserListTile(recievedUsers[index]);
                      },
                    );
                  }
                  return null;
                }),
          ),
        ),
      ],
    );
  }
}

class UserListTile extends StatelessWidget {
  final User user;
  UserListTile(this.user);

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
                    ? NetworkImage(user.image)
                    : NetworkImage(
                            'https://post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/02/322868_1100-800x825.jpg') ??
                        CircularProgressIndicator(),
              ),
            ),
          ),
          btnOkText: 'View Profile',
          btnOkOnPress: () {},
          btnOkColor: Colors.blueGrey,
          title: user.fullName,
          desc: '@${user.username}',
        ).show();
      },
      child: ListTile(
        leading: ClipOval(
          child: Image.network(
            user.image,
            height: getProportionateScreenWidth(55),
            width: getProportionateScreenWidth(55),
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          user.fullName,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '@${user.username}',
          style: TextStyle(color: Colors.black38),
        ),
      ),
    );
  }
}
