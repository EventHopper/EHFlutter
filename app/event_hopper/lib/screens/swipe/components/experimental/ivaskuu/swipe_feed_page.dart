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
        VerticalSpacing(of: 40),
        SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.hardEdge,
            primary: true,
            child: Column(children: [
              Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: CardsSectionAlignment(
                      context,
                      Provider.of<SessionManager>(context, listen: false)
                          .eventsFromCategory
                          .asStream()))
            ])),
        buttonsRow()
      ],
    );
  }

  Widget buttonsRow() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton(
            heroTag: "swipe-discard",
            onPressed: () {},
            mini: true,
            backgroundColor: Colors.white,
            child: Icon(Icons.close, color: Colors.red),
          ),
          Padding(padding: EdgeInsets.only(right: 12.0)),
          FloatingActionButton(
            heroTag: "swipe-accept",
            onPressed: () {},
            backgroundColor: Colors.white,
            child: Icon(Icons.favorite, color: Colors.green),
          ),
          Padding(padding: EdgeInsets.only(right: 12.0)),
          FloatingActionButton(
            heroTag: "swipe-bookmark",
            mini: true,
            onPressed: () {},
            backgroundColor: Colors.white,
            child: Icon(Icons.star, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
