import 'package:flutter/material.dart';

class Category {
  final String name, image;

  Category({@required this.name, @required this.image});
}

// Demo List of Top Travelers
List<Category> topCategories = [
  category1,
  category2,
  category3,
  category4,
  category5
];

// demo user
Category category1 = Category(
    name: "Music",
    image:
        "https://media1.tenor.com/images/9f241eb34ba69f136ab7673d8ab5fe85/tenor.gif?itemid=4322926");
Category category2 = Category(
    name: "Dance",
    image:
        "https://media1.tenor.com/images/57696cc0dfe126ac84ed5f04828abdc3/tenor.gif?itemid=9152583");
Category category3 = Category(
    name: "Art",
    image:
        "https://media1.tenor.com/images/c76e1b21c7544e383b9c6a9829d8f6aa/tenor.gif?itemid=4952929");
Category category4 = Category(
    name: "Nature",
    image:
        "https://media1.tenor.com/images/23da875fa07afb4a71dd66e22265c8a7/tenor.gif?itemid=7384355");
Category category5 = Category(
    name: "Surprise",
    image:
        "https://media1.tenor.com/images/6b3160004ff0a49639ddbfea2d895ee5/tenor.gif?itemid=5225075");
