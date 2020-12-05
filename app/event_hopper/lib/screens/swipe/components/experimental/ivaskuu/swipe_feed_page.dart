import 'package:flutter/material.dart';
import 'cards_section_alignment.dart';
import 'cards_section_draggable.dart';

class SwipeFeedPage extends StatefulWidget {
  @override
  _SwipeFeedPageState createState() => _SwipeFeedPageState();
}

class _SwipeFeedPageState extends State<SwipeFeedPage> {
  bool showAlignmentCards = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
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
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          showAlignmentCards
              ? SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.hardEdge,
                  primary: true,
                  child: Column(
                      // verticalDirection: VerticalDirection.up,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: CardsSectionAlignment(context))
                      ]))
              : CardsSectionDraggable(),
          buttonsRow()
        ],
      ),
    );
  }

  Widget buttonsRow() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 14.0),
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
