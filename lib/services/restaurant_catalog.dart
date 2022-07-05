import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:yelp_review/services/secret_services.dart';

class CatalogCalls {

  Future<LocationData?>? initLocationService() async {
    var location = Location();

    if (!await location.serviceEnabled()) {
      if (!await location.requestService()) {
        return null;
      }
    }

    var permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != PermissionStatus.granted) {
        return null;
      }
    }

    var loc = await location.getLocation();
    //print("${loc.latitude} ${loc.longitude}");

    return loc;
  }

  Future<RestaurantCatalog> fetchCatalog() async {
    final location = await initLocationService();

    final latitude = location?.latitude.toString();
    final longitude = location?.longitude.toString();

    final response = await http.get(
        Uri.parse(
            'https://api.yelp.com/v3/businesses/search?latitude=$latitude&longitude=$longitude'),
        headers: {
          'Authorization': yelpKey,
        });

    final responseJson = jsonDecode(response.body);

    return RestaurantCatalog.fromJson(responseJson);
  }
}

class RestaurantCatalog {
  final int totalRestaurants;
  final List<Businesses> businesses;

  RestaurantCatalog({
    required this.totalRestaurants,
    required this.businesses,
  });

  factory RestaurantCatalog.fromJson(Map<String, dynamic> json) {
    return RestaurantCatalog(
      totalRestaurants: json['total'],
      businesses: (json['businesses'] as List)
          .map((business) => Businesses.fromJson(business)).toList(),
    );
  }
}

class Businesses {
  final double rating;
  final String price;
  final String alias;
  final String name;
  final String imageUrl;
  final double distance;

  final List<Category> categories;

  Businesses({
    required this.rating,
    required this.price,
    required this.alias,
    required this.name,
    required this.imageUrl,
    required this.distance,
    required this.categories,
  });

  factory Businesses.fromJson(Map<String, dynamic> json) {
    return Businesses(
        rating: json['rating'],
        price: json['price'],
        alias: json['alias'],
        name: json['name'],
        imageUrl: json['image_url'],
        distance: json['distance'],
        categories: (json['categories'] as List)
            .map((categoryJson) => Category.fromJson(categoryJson))
            .toList(),
    );
  }

}

class Category {
  final String title;

  const Category({
    required this.title,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        title: json['title'],
    );
  }
}
