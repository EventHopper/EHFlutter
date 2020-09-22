import 'package:flutter/material.dart';

class Category {
  final String name, image;

  Category({@required this.name, @required this.image});
}

// Demo List of Top Travelers
List<Category> topCategories = [category1, category2, category3, category4, category5];

// demo user
Category category1 = Category(name: "Music", image: "https://api.time.com/wp-content/uploads/2019/08/tallconcertshirt.jpeg");
Category category2 = Category(name: "Dance", image: "https://blogmedia.evbstatic.com/wp-content/uploads/wpmulti/sites/3/2020/05/DAYBREAKER_nyc_sasha_1010_1505.jpg");
Category category3 = Category(name: "Art", image: "https://quizzma.com/wp-content/uploads/2020/08/after-10-12-art-design-college.jpg");
Category category4 = Category(name: "Nature", image: "https://s3-us-west-2.amazonaws.com/uw-s3-cdn/wp-content/uploads/sites/6/2017/11/04133712/waterfall.jpg");
Category category5 = Category(name: "Misc", image: "https://st4.depositphotos.com/16499398/21199/v/380/depositphotos_211990674-stock-illustration-therefore-symbol-icon-vector-sign.jpg");
