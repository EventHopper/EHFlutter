import 'package:EventHopper/screens/route_config.dart';
import 'package:EventHopper/utils/screen_navigator.dart';
import 'package:flutter/material.dart';
import 'package:EventHopper/utils/size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            Stack(
              overflow: Overflow.visible,
              alignment: Alignment.center,
              children: [
                Image.network(
                  // "https://images.unsplash.com/photo-1598649975444-0e53df8f8edd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=630&q=80",
                  // "https://images.unsplash.com/photo-1507608616759-54f48f0af0ee?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
                  // "https://images.unsplash.com/photo-1533174072545-7a4b6ad7a6c3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80",
                  // "https://images.unsplash.com/photo-1541532713592-79a0317b6b77?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
                  // "https://images.unsplash.com/photo-1539146395724-de109483bdd2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1115&q=80",
                  "https://images.unsplash.com/photo-1494668257191-e237c341e7f6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=686&q=80",
                  // "https://images.unsplash.com/photo-1598450938631-cc9e7e33f28a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=701&q=80",
                  // "https://images.unsplash.com/photo-1557084672-c82bc51a4e19?ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80",
                  // "https://images.unsplash.com/photo-1504591504549-8ce1589ea6f6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  filterQuality: FilterQuality.high,
                ),
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.6), BlendMode.dstATop),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    color: Colors.black,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    VerticalSpacing(),
                    Text(
                      "Experience more",
                      style: TextStyle(color: Colors.white),
                    ),
                    VerticalSpacing(),
                    VerticalSpacing(),
                    VerticalSpacing(),
                    Center(
                      child: MaterialButton(
                        height: 45,
                        color: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0)),
                        child: Text(
                          "Create an account",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          ScreenNavigator.navigateSwipe(
                              context, RouteConfig.registration);
                        },
                      ),
                    )
                  ],
                ),
                Positioned(
                  bottom: getProportionateScreenWidth(50),
                  child: Column(
                    children: [
                      MaterialButton(
                        child: Text(
                          "already have an account? Log in",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          ScreenNavigator.navigateSwipe(
                              context, RouteConfig.login);
                        },
                      ),
                      MaterialButton(
                        child: Text(
                          "Skip (Testing purposes only)",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          ScreenNavigator.navigateSwipe(
                              context, RouteConfig.home,
                              replace: true);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
