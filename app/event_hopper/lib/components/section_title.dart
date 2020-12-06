import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/size_config.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key key,
    @required this.title,
    @required this.press,
    this.actionTitle,
  }) : super(key: key);

  final String title;
  final String actionTitle;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(kDefaultPadding),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: getProportionateScreenWidth(20),
            ),
          ),
          Spacer(),
          InkWell(
            highlightColor: Colors.lightBlueAccent,
            splashColor: Colors.blueAccent,
            focusColor: Colors.blueAccent,
            borderRadius: BorderRadius.circular(40),
            onTap: press,
            child: actionTitle != null ? Text(actionTitle) : Container(),
          ),
        ],
      ),
    );
  }
}
