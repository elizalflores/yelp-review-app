import 'dart:convert';

import 'package:http/http.dart' as http;

class YelpCall {
  Future<Restaurant> fetchRestaurant() async {
    final response = await http.get(
        Uri.parse(
            'https://api.yelp.com/v3/businesses/north-india-restaurant-san-francisco'),
        headers: {
          'Authorization':
              'Bearer wigdsJl9SwNA3dZ3S0hjTtXyUZy6iLmQPFcPEkN2J_nVGcQOoPT5g1JCmF4IEjvAmArwWSCFR6Y-0nk_drkVefLFrrKpDA3LsLsP39U13rf3eCqMSffpH-fIu22mYnYx',
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
  final List<Hours> hours;
  final List<String>? photos;

  const Restaurant({
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.price,
    required this.location,
    required this.categories,
    required this.hours,
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
      hours: (json['hours'] as List)
          .map((categoryJson) => Hours.fromJson(categoryJson))
          .toList(),
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
  //final List<DailyHours> restaurantHours;

  const Hours({
    required this.isOpenNow,
    //required this.restaurantHours,
  });

  factory Hours.fromJson(Map<String, dynamic> json) {
    return Hours(
      isOpenNow: json['is_open_now'],
      /*restaurantHours: (json['open'] as List).map((restaurantHours)
                          => DailyHours.fromJson(restaurantHours)).toList(),*/
    );
  }
}

class DailyHours {
  final String opens;
  final String closes;
  final String dayOfTheWeek;

  DailyHours({
    required this.opens,
    required this.closes,
    required this.dayOfTheWeek,
  });

  factory DailyHours.fromJson(Map<String, dynamic> json) {
    return DailyHours(
      opens: json['start'],
      closes: json['end'],
      dayOfTheWeek: json['day'],
    );
  }
}

class ReviewsCall {
  Future<GeneralReviewInfo> fetchReviews() async {
    final response = await http.get(
        Uri.parse(
            'https://api.yelp.com/v3/businesses/north-india-restaurant-san-francisco/reviews'),
        headers: {
          'Authorization':
          'Bearer wigdsJl9SwNA3dZ3S0hjTtXyUZy6iLmQPFcPEkN2J_nVGcQOoPT5g1JCmF4IEjvAmArwWSCFR6Y-0nk_drkVefLFrrKpDA3LsLsP39U13rf3eCqMSffpH-fIu22mYnYx',
        });

    final responseJson = jsonDecode(response.body);

    return GeneralReviewInfo.fromJson(responseJson);
  }
}

class GeneralReviewInfo {
  final int totalReviews;
  final List<IndividualReviews> individuals;

  GeneralReviewInfo({
    required this.totalReviews,
    required this.individuals,
  });

  factory GeneralReviewInfo.fromJson(Map<String, dynamic> json) {
    return GeneralReviewInfo(
      totalReviews: json['total'],
      individuals:
        (json['reviews'] as List)
            .map((review) => IndividualReviews.fromJson(review)).toList()
    );
  }
}

class IndividualReviews {
  final num rating;
  final String reviewText;
  final User user;

  IndividualReviews({
    required this.rating,
    required this.reviewText,
    required this.user,
  });

  factory IndividualReviews.fromJson(Map<String, dynamic> json) {
    return IndividualReviews(
      rating: json['rating'],
      reviewText: json['text'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final String name;
  final String? imageUrl;

  User({
    required this.name,
    required this.imageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      imageUrl: json['image_url'],
    );
  }
}


