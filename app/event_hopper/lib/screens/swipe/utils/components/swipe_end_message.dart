import 'package:flutter/material.dart';
import 'package:EventHopper/utils/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SwipeEndMessage extends StatelessWidget {
  const SwipeEndMessage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: getProportionateScreenHeight(100)),
            SvgPicture.asset(
              'assets/images/donepurp.svg',
              height: getProportionateScreenHeight(120),
            ),
            VerticalSpacing(),
            Container(
                width: getProportionateScreenWidth(300),
                child: Column(
                  children: [
                    Text(
                      "FINISHED",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 23,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      "Check back later for more!",
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
