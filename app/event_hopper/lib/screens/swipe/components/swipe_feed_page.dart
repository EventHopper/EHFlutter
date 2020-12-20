import 'package:EventHopper/utils/size_config.dart';
import 'package:EventHopper/services/state-management/session_manager.dart';
import 'package:flutter/material.dart';
import 'cards_section_alignment.dart';
import 'package:provider/provider.dart';

class SwipeFeedPage extends StatefulWidget {
  @override
  _SwipeFeedPageState createState() => _SwipeFeedPageState();
}

class _SwipeFeedPageState extends State<SwipeFeedPage> {
  bool showAlignmentCards = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VerticalSpacing(of: 20),
        SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.hardEdge,
            primary: true,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                  height: MediaQuery.of(context).size.height * 0.88,
                  child: CardsSectionAlignment(
                      context,
                      Provider.of<SessionManager>(context, listen: false)
                          .eventsFromCategory
                          .asStream()))
            ])),
      ],
    );
  }
}
