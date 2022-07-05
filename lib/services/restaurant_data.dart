import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yelp_review/services/secret_services.dart';

class RestaurantCalls {
  Future<Restaurant> fetchRestaurant(String alias) async {
    final response = await http.get(
        Uri.parse(
            'https://api.yelp.com/v3/businesses/$alias'),
        headers: {
          'Authorization': yelpKey,
        });

    final responseJson = jsonDecode(response.body);

    return Restaurant.fromJson(responseJson);
  }
}

class Restaurant {
  final String name;
  final String imageUrl;
  final double rating;
  final String price;

  final Location location;

  final List<Category> categories;
  final List<Hours>? hours;
  final List<String>? photos;

  const Restaurant({
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.price,
    required this.location,
    required this.categories,
    this.hours,
    this.photos,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      name: json['name'],
      imageUrl: json['image_url'],
      rating: json['rating'],
      price: json['price'],
      location: Location.fromJson(json['location']),
      categories: (json['categories'] as List)
          .map((categoryJson) => Category.fromJson(categoryJson))
          .toList(),
      hours: json.containsKey('hours') ? (json['hours'] as List)
          .map((categoryJson) => Hours.fromJson(categoryJson))
          .toList() : null,
      photos: (json['photos'] as List).map((photo) => photo.toString()).toList(),
    );
  }
}

class Category {
  final String alias;
  final String title;

  const Category({
    required this.alias,
    required this.title,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(alias: json['alias'], title: json['title']);
  }
}

class Location {
  final DisplayAddress displayAddress;

  Location({
    required this.displayAddress,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        displayAddress: DisplayAddress.fromStringArray(
            (json['display_address'] as List)
                .map((address) => address.toString())
                .toList())
    );
  }
}

class DisplayAddress {
  final String addressLine1;
  final String addressLine2;

  const DisplayAddress({
    required this.addressLine1,
    required this.addressLine2,
  });

  factory DisplayAddress.fromStringArray(List<String> addresses) {
    return DisplayAddress(
      addressLine1: addresses[0],
      addressLine2: addresses[1],
    );
  }
}

class Hours {
  final bool isOpenNow;
  final List<DailyHours> restaurantHours;

  const Hours({
    required this.isOpenNow,
    required this.restaurantHours,
  });

  factory Hours.fromJson(Map<String, dynamic> json) {
    return Hours(
      isOpenNow: json['is_open_now'],
      restaurantHours: (json['open'] as List).map((restaurantHours)
                          => DailyHours.fromJson(restaurantHours)).toList(),
    );
  }
}

class DailyHours {
  final bool isOvernight;
  final String startTime;
  final String endTime;
  final int day;

  DailyHours({
    required this.isOvernight,
    required this.startTime,
    required this.endTime,
    required this.day,
  });

  factory DailyHours.fromJson(Map<String, dynamic> json) {
    return DailyHours(
      isOvernight: json['is_overnight'],
      startTime: json['start'],
      endTime: json['end'],
      day: json['day'],
    );
  }
}
