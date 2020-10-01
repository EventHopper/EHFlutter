import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'search_fields.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: getProportionateScreenWidth(25)),
      child: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.center,
        children: [
          Image.network(
            "https://gamespot1.cbsistatic.com/uploads/scale_super/1562/15626911/3395984-4.jpg",
            fit: BoxFit.cover,
            width: double.infinity,
            height: getProportionateScreenHeight(315),
            filterQuality: FilterQuality.high,
          ),
          ColorFiltered(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.6), BlendMode.dstATop),
            child: Container(
              height: getProportionateScreenHeight(315),
              width: double.infinity,
              color: Colors.black,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: getProportionateScreenHeight(80)),
              Text(
                "EventHopper",
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(42),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 0.5),
              ),
              Text(
                "Experience more",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          Positioned(
            bottom: getProportionateScreenWidth(-25),
            child: SearchField(),
          )
        ],
      ),
    );
  }
}
