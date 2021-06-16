import 'package:EventHopper/services/eh-server/api_service.dart';
import 'package:EventHopper/services/eh-server/api_wrapper.dart';
import 'package:EventHopper/utils/constants.dart';
import 'package:EventHopper/screens/route_config.dart';
import 'package:EventHopper/components/section_title.dart';
import 'package:EventHopper/services/state-management/session_manager.dart';
import 'package:EventHopper/components/events_carousel.dart';
import 'package:EventHopper/utils/system_utils.dart';
import 'package:flutter/material.dart';
import 'package:EventHopper/utils/size_config.dart';
import 'package:intl/intl.dart';
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
      child: Consumer<SessionManager>(
        builder: (BuildContext context, SessionManager sessionManager,
                Widget widget) =>
            SingleChildScrollView(
          clipBehavior: Clip.none,
          child: SafeArea(
            top: false,
            child: Column(
              children: [
                HomeHeader(),
                VerticalSpacing(),
                EventsCarousel(
                  events: Provider.of<SessionManager>(context)
                      .eventsNearMe
                      .asStream(),
                  sectionTitle: SectionTitle(
                    title: "Selected for you",
                    press: () {},
                    actionTitle: "See All",
                  ),
                ),
                // VerticalSpacing(of: 5),
                VerticalSpacing(),
                VerticalSpacing(),
                new EventsCarousel(
                  events: EventHopperAPI.eventHopperApiService(
                          Provider.of<SessionManager>(context).apiMode)
                      .getEventsByCity(
                        sessionManager.city,
                        page: 0,
                        dateAfter:
                            DateTime.now().subtract(new Duration(days: 1)),
                        dateBefore: DateTime.now().add(new Duration(days: 13)),
                      )
                      .asStream(),
                  sectionTitle: SectionTitle(
                    title:
                        // "Events this ${DateFormat('EEEE').format(DateTime.now())}",
                        "Popular Near You",
                    press: () {},
                    actionTitle: "See All",
                  ),
                ),
                VerticalSpacing(),
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
                VerticalSpacing(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

DateTime getWeekend() {
  var dayOfWeek = 1;
  DateTime date = DateTime.now();
  var nextSaturday =
      date.subtract(Duration(days: date.weekday - dayOfWeek)).toIso8601String();
}
