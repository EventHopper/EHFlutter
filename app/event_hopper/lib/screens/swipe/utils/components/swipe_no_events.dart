import 'package:flutter/material.dart';
import 'package:EventHopper/utils/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:EventHopper/components/top_categories.dart';

class SwipeNoEvents extends StatelessWidget {
  const SwipeNoEvents({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(650),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: getProportionateScreenHeight(100)),
            SvgPicture.asset(
              'assets/images/friends-movie.svg',
              height: getProportionateScreenHeight(120),
            ),
            VerticalSpacing(),
            Container(
                width: getProportionateScreenWidth(300),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Get Started!",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 23,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      "Select an Event Category!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        wordSpacing: 1,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey[350],
                        fontSize: 18,
                      ),
                    ),
                    SwipeCategories()
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
