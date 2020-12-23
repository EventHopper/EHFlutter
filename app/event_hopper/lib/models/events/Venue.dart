import 'package:flutter/material.dart';

class Venue {
  final String id,
      name,
      street,
      city,
      state,
      countryCode,
      zip,
      timezone,
      imageURL;
  final double latitude, longitude;

  static const String defaultImage =
      'https://www.thesslstore.com/blog/wp-content/uploads/2017/05/circle-with-i-1.png';

  Venue({
    this.id,
    @required this.name,
    @required this.street,
    @required this.city,
    @required this.state,
    @required this.countryCode,
    @required this.zip,
    this.latitude,
    this.longitude,
    this.timezone,
    this.imageURL = defaultImage,
  });

  @override
  String toString() {
    String result = '$name\n$street\n$city, $state, $zip';
    return result;
  }

  String toQueryString() {
    String result = '$name, $street, $city, $state, $zip';
    return result;
  }

  @override
  factory Venue.fromJson(Map<String, dynamic> venueSchema) {
    bool hasImage = venueSchema['imageURL'] != null;
    return Venue(
      id: venueSchema['_id'] as String,
      name: venueSchema['name'] as String,
      street: venueSchema['street'] as String,
      city: venueSchema['city'] as String,
      state: venueSchema['state'] as String,
      countryCode: venueSchema['countryCode'] as String,
      zip: venueSchema['zip'] as String,
      latitude: venueSchema['location']['latitude'] as double,
      longitude: venueSchema['location']['longitude'] as double,
      timezone: venueSchema['location']['timezone'] as String,
      imageURL: hasImage ? venueSchema['imageURL'] as String : defaultImage,
    );
  }
}
