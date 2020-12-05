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
        VerticalSpacing(of: 45),
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
                      Provider.of<SessionManager>(context, listen: true)
                          .eventsFromCategory
                          .asStream()))
            ])),
        buttonsRow()
      ],
    );
  }

  Widget buttonsRow() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // FloatingActionButton(
          //   mini: true,
          //   heroTag: "btn1",
          //   onPressed: () {},
          //   backgroundColor: Colors.white,
          //   child: Icon(Icons.loop, color: Colors.yellow),
          // ),
          // Padding(padding: EdgeInsets.only(right: 8.0)),
          FloatingActionButton(
            heroTag: "btn2",
            onPressed: () {},
            mini: true,
            backgroundColor: Colors.white,
            child: Icon(Icons.close, color: Colors.red),
          ),
          Padding(padding: EdgeInsets.only(right: 12.0)),
          FloatingActionButton(
            heroTag: "btn3",
            onPressed: () {},
            backgroundColor: Colors.white,
            child: Icon(Icons.favorite, color: Colors.green),
          ),
          Padding(padding: EdgeInsets.only(right: 12.0)),
          FloatingActionButton(
            heroTag: "btn4",
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
