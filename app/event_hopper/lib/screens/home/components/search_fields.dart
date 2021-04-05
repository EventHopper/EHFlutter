import 'package:EventHopper/screens/route_config.dart';
import 'package:EventHopper/utils/screen_navigator.dart';
import 'package:flutter/material.dart';

import '../../../utils/size_config.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ScreenNavigator.navigate(context, RouteConfig.search);
      },
      child: Hero(
        tag: 'thisIsATestTag',
        child: GestureDetector(
          onTap: () {
            ScreenNavigator.navigate(context, RouteConfig.search);
          },
          onSecondaryTap: () {
            ScreenNavigator.navigate(context, RouteConfig.search);
          },
          child: Material(
            color: Color(0x00000000),
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
              child: IgnorePointer(
                ignoringSemantics: true,
                ignoring: true,
                child: TextField(
                  onTap: () {
                    ScreenNavigator.navigate(context, RouteConfig.search);
                  },
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    hintText: "Search EventHopper...",
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
        ),
      ),
    );
  }
}
