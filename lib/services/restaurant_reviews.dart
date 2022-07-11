import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yelp_review/services/secret_services.dart';

class ReviewCalls {
  Future<GeneralReviewInfo> fetchReviews(String alias) async {
    final response = await http.get(
        Uri.parse(
            'https://api.yelp.com/v3/businesses/$alias/reviews'),
        headers: {
          'Authorization': 'Bearer $yelpKey',
        });

    final responseJson = jsonDecode(response.body);

    return GeneralReviewInfo.fromJson(responseJson);
  }
}

class GeneralReviewInfo {
  final int? totalReviews;
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

  const User({
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
