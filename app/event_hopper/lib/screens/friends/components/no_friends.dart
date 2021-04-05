import 'package:flutter/material.dart';
import 'package:EventHopper/utils/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

class NoFriendsMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Future<List<Event>> events = getEvents();

    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/orgs.svg',
              height: getProportionateScreenHeight(180),
            ),
            VerticalSpacing(),
            VerticalSpacing(),
            Container(
                width: getProportionateScreenWidth(300),
                child: Column(
                  children: [
                    Text(
                      "NO FRIENDS ... YET!",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 23,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    VerticalSpacing(),
                    VerticalSpacing(),
                    Text(
                      "Find, follow and organize with friends!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        wordSpacing: 1,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey[350],
                        fontSize: 18,
                      ),
                    ),
                  ],
                )),
            VerticalSpacing(),
            VerticalSpacing(),
          ],
        ),
      ),
    );
  }
}
