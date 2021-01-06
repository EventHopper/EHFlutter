import 'package:EventHopper/models/events/Event.dart';
import 'package:EventHopper/screens/swipe/utils/components/swipe_no_events.dart';
import 'package:EventHopper/utils/size_config.dart';
import 'package:EventHopper/services/state-management/session_manager.dart';
import 'package:flutter/material.dart';
import 'swipe_sequence_section.dart';
import 'package:provider/provider.dart';

class SwipeFeedPage extends StatefulWidget {
  @override
  _SwipeFeedPageState createState() => _SwipeFeedPageState();
}

class _SwipeFeedPageState extends State<SwipeFeedPage> {
  @override
  Widget build(BuildContext context) {
    Future<List<Event>> eventsFromCategory =
        Provider.of<SessionManager>(context, listen: false).eventsFromCategory;
    return Column(
      children: [
        VerticalSpacing(of: 20),
        SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            clipBehavior: Clip.none,
            primary: true,
            child: Column(children: [
              eventsFromCategory != null
                  ? Container(
                      height: MediaQuery.of(context).size.height * 0.88,
                      child: SwipeSequenceSection(
                          context, eventsFromCategory.asStream()))
                  : Container(child: SwipeNoEvents())
            ])),
      ],
    );
  }
}
