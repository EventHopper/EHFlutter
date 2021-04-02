import 'package:EventHopper/models/users/User.dart';
import 'package:EventHopper/services/eh-server/api_service.dart';
import 'package:EventHopper/services/state-management/session_manager.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:flutter/material.dart';
import 'package:EventHopper/utils/constants.dart';
import 'package:EventHopper/utils/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
  }

  bool loadingProfileImage = false;
  PickedFile _profileImageFile;

  Future getImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.getImage(
      source: source,
    );
    _profileImageFile = pickedFile;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SessionManager>(
      builder: (BuildContext context, SessionManager sessionManager,
              Widget widget) =>
          FutureBuilder<User>(
        future: sessionManager.currentUser,
        builder: (context, user) => Container(
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
                            GestureDetector(
                                onTap: () {
                                  AwesomeDialog(
                                    context: context,
                                    headerAnimationLoop: false,
                                    customHeader: Container(
                                      height: 120,
                                      width: 120,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image(
                                          fit: BoxFit.cover,
                                          image: user.hasData
                                              ? NetworkImage(user.data.image)
                                              : Container(),
                                        ),
                                      ),
                                    ),
                                    title: 'Profile Image',
                                    desc: 'Change Profile Picture',
                                    btnCancelOnPress: () async {
                                      setState(() {
                                        loadingProfileImage = true;
                                      });
                                      await getImage(
                                        ImageSource.camera,
                                      );
                                      if (_profileImageFile != null) {
                                        await eventHopperApiService
                                            .uploadUserMedia(
                                                _profileImageFile.path,
                                                fbAuth.FirebaseAuth.instance
                                                    .currentUser.uid,
                                                'public')
                                            .then((value) =>
                                                fetchCurrentUserData(context));
                                        setState(() {
                                          loadingProfileImage = false;
                                        });
                                      } else {
                                        setState(() {
                                          loadingProfileImage = false;
                                        });
                                      }
                                    },
                                    btnOkOnPress: () async {
                                      setState(() {
                                        loadingProfileImage = true;
                                      });
                                      await getImage(ImageSource.gallery);
                                      if (_profileImageFile != null) {
                                        await eventHopperApiService
                                            .uploadUserMedia(
                                                _profileImageFile.path,
                                                fbAuth.FirebaseAuth.instance
                                                    .currentUser.uid,
                                                'public')
                                            .then((value) =>
                                                fetchCurrentUserData(context));
                                      }
                                      loadingProfileImage = false;

                                      setState(() {});
                                    },
                                    btnCancelText: 'Camera',
                                    btnCancelColor: kPrimaryColor,
                                    btnOkText: 'Gallery...',
                                    btnOkColor: kPrimaryColor,
                                  ).show();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30)),
                                  height: 135,
                                  width: 120,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 7,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: ModalProgressHUD(
                                            inAsyncCall: loadingProfileImage,
                                            child: Container(
                                              height: 120,
                                              width: 120,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                child: Image(
                                                  fit: BoxFit.cover,
                                                  image: user.hasData
                                                      ? NetworkImage(
                                                          user.data.image)
                                                      : Container(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          'change photo',
                                          style: TextStyle(
                                              color: kPrimaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                            SizedBox(
                              width: 20,
                            ),
                            Consumer<SessionManager>(
                              builder: (BuildContext context,
                                      SessionManager sessionManager,
                                      Widget widget) =>
                                  FutureBuilder<User>(
                                future: sessionManager.currentUser,
                                builder: (context, user) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user.data.fullName,
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
                                      '@${user.data.username}',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 14,
                                        color: const Color(0xff666666),
                                        letterSpacing: 0.126,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
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

  void fetchCurrentUserData(BuildContext context) {
    Provider.of<SessionManager>(context, listen: false).fetchCurrentUserData();
  }
}
