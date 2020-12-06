import 'package:EventHopper/utils/size_config.dart';
import 'package:EventHopper/utils/system_utils.dart';
import 'package:flutter/material.dart';

class AdBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: getProportionateScreenWidth(400),
      child: Material(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(300),
        child: Ink.image(
          image: AssetImage('assets/images/blackpanther-thin-ad.png'),
          fit: BoxFit.cover,
          alignment:
              Alignment.lerp(Alignment.topCenter, Alignment.bottomCenter, 0.6),
          child: InkWell(onTap: () {
            launchURL('https://www.playstation.com/en-us/ps5/');
          }),
        ),
      ),
    );
  }
}
