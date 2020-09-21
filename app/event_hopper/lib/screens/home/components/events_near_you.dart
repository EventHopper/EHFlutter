import 'package:flutter/material.dart';
import 'package:travel/components/place_card.dart';
import 'package:travel/components/section_title.dart';
import 'package:travel/models/EventSpotlight.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class EventsNearYou extends StatelessWidget {
  const EventsNearYou({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle( 
          title: "Events Near You",
          press: () {},
        ),
        VerticalSpacing(of: 20),
        SingleChildScrollView(
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                events.length,
                (index) => Padding(
                  padding: EdgeInsets.only(
                      left: getProportionateScreenWidth(kDefaultPadding)),
                  child: PlaceCard(
                    eventSpotlight: events[index],
                    press: () {},
                  ),
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(kDefaultPadding),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
