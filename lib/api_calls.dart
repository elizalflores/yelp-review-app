import 'dart:convert';

import 'package:http/http.dart' as http;

class YelpCall {

  Future<Restaurant> fetchRestaurant() async {
    final response = await http.get(
        Uri.parse(
            'https://api.yelp.com/v3/businesses/north-india-restaurant-san-francisco'),
        headers: {
          'Authorization': 'Bearer wigdsJl9SwNA3dZ3S0hjTtXyUZy6iLmQPFcPEkN2J_nVGcQOoPT5g1JCmF4IEjvAmArwWSCFR6Y-0nk_drkVefLFrrKpDA3LsLsP39U13rf3eCqMSffpH-fIu22mYnYx',
        });

    final responseJson = jsonDecode(response.body);

    return Restaurant.fromJson(responseJson);
  }
}

class Restaurant {
  final String name;

  const Restaurant({
    required this.name,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      name: json['name'],
    );
  }
}
