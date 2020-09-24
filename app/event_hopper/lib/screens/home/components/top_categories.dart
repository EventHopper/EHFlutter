import 'package:flutter/material.dart';
import 'package:travel/components/section_title.dart';
import 'package:travel/models/Category.dart';
import 'package:travel/models/User.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class EventCategories extends StatelessWidget {
  const EventCategories({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(title: "What are you feeling like?", press: () {}),
        VerticalSpacing(of: 20),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(kDefaultPadding),
          ),
          padding: EdgeInsets.all(getProportionateScreenWidth(24)),
          // height: getProportionateScreenWidth(143),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [kDefualtShadow],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(
                topCategories.length,
                (index) => CategoryCard(
                  category: topCategories[index],
                  press: () {},
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
    @required this.category,
    @required this.press,
  }) : super(key: key);

  final Category category;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          ClipOval(
            child: Image.network(
              category.image,
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(55),
              fit: BoxFit.cover,
            ),
          ),
          VerticalSpacing(of: 10),
          Text(
            category.name,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  const UserCard({
    Key key,
    @required this.user,
    @required this.press,
  }) : super(key: key);

  final User user;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          ClipOval(
            child: Image.asset(
              user.image,
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(55),
              fit: BoxFit.cover,
            ),
          ),
          VerticalSpacing(of: 10),
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11),
          ),
        ],
      ),
    );
  }
}