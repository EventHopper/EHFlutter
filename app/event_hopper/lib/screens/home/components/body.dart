import 'package:EventHopper/utils/constants.dart';
import 'package:EventHopper/screens/route_config.dart';
import 'package:EventHopper/components/section_title.dart';
import 'package:EventHopper/services/state-management/session_manager.dart';
import 'package:EventHopper/components/events_carousel.dart';
import 'package:EventHopper/utils/system_utils.dart';
import 'package:flutter/material.dart';
import 'package:EventHopper/utils/size_config.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:EventHopper/utils/screen_navigator.dart';
import 'home_header.dart';
import '../../../components/top_categories.dart';
import 'package:EventHopper/components/ad_banner.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // You have to call SizeConfig on your starting page
    SizeConfig().init(context);
    final RefreshController _refreshController =
        RefreshController(initialRefresh: false);
    void _onRefresh() async {
      // monitor network fetch
      Provider.of<SessionManager>(context, listen: false)
          .updateInitialState(false);
      Provider.of<SessionManager>(context, listen: false).fetchEventsNearMe();
      ScreenNavigator.navigate(context, RouteConfig.home);

      _refreshController.refreshCompleted();
    }

    return SmartRefresher(
      controller: _refreshController,
      onRefresh: _onRefresh,
      header: WaterDropMaterialHeader(
        backgroundColor: Colors.white,
        color: kTextColor,
      ),
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              HomeHeader(),
              VerticalSpacing(),
              EventsCarousel(
                events: Provider.of<SessionManager>(context, listen: false)
                    .eventsNearMe
                    .asStream(),
                sectionTitle: SectionTitle(
                  title: "Events Near You",
                  press: () {},
                  actionTitle: "See All",
                ),
              ),
              // VerticalSpacing(of: 5),
              EventCategories(),
              VerticalSpacing(),
              SectionTitle(
                title: "Featured",
                press: () {
                  launchURL('https://www.playstation.com/en-us/ps5/');
                },
                actionTitle: "Learn More",
              ),
              VerticalSpacing(),
              AdBanner(),
              VerticalSpacing(),
            ],
          ),
        ),
      ),
    );
  }
}
