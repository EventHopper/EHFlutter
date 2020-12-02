import 'package:EventHopper/services/state-management/session_manager.dart';
import 'package:flutter/material.dart';
import 'cards_section_alignment.dart';
import 'cards_section_draggable.dart';
import 'package:provider/provider.dart';

class SwipeFeedPage extends StatefulWidget {
  @override
  _SwipeFeedPageState createState() => _SwipeFeedPageState();
}

class _SwipeFeedPageState extends State<SwipeFeedPage> {
  bool showAlignmentCards = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        // leading: IconButton(
        //     onPressed: () {}, icon: Icon(Icons.settings, color: Colors.grey)),
        title: Switch(
          onChanged: (bool value) => setState(() => showAlignmentCards = value),
          value: showAlignmentCards,
          activeColor: Colors.red,
        ),
        // actions: <Widget>[
        //   IconButton(
        //       onPressed: () {},
        //       icon: Icon(Icons.question_answer, color: Colors.grey)),
        // ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          showAlignmentCards
              ? CardsSectionAlignment(
                  context,
                  Provider.of<SessionManager>(context, listen: true)
                      .eventsFromCategory
                      .asStream())
              : CardsSectionDraggable(),
          buttonsRow()
        ],
      ),
    );
  }

  Widget buttonsRow() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 48.0),
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
