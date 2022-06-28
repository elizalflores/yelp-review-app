import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

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
          'Authorization':
          'Bearer wigdsJl9SwNA3dZ3S0hjTtXyUZy6iLmQPFcPEkN2J_nVGcQOoPT5g1JCmF4IEjvAmArwWSCFR6Y-0nk_drkVefLFrrKpDA3LsLsP39U13rf3eCqMSffpH-fIu22mYnYx',
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
          .map((business) => Businesses.fromJson(business))
          .where((business) => !business.isClosed)
          .toList(),
    );
  }
}

class Businesses {
  final double rating;
  final String price;
  final String alias;//need this to pass into navigation
  final String name;
  final String imageUrl;
  final bool isClosed;//permanentely closed

  final List<Category> categories;

  Businesses({
    required this.rating,
    required this.price,
    required this.alias,
    required this.name,
    required this.imageUrl,
    required this.isClosed,
    required this.categories,
  });

  factory Businesses.fromJson(Map<String, dynamic> json) {
    return Businesses(
        rating: json['rating'],
        price: json['price'],
        alias: json['alias'],
        name: json['name'],
        imageUrl: json['image_url'],
        isClosed: json['is_closed'],
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
