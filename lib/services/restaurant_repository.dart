import 'package:yelp_review/services/restaurant_catalog.dart';
import 'package:yelp_review/services/restaurant_data.dart';
import 'package:yelp_review/services/restaurant_reviews.dart';

class RestaurantRepository {
  final restaurantCatalog = CatalogCalls();
  final restaurantData = RestaurantCalls();
  final restaurantReviews = ReviewCalls();

  static final RestaurantRepository _singleton = RestaurantRepository._internal();

  factory RestaurantRepository() {
    return _singleton;
  }

  RestaurantRepository._internal();

  Future<RestaurantCatalog> fetchCatalog() async {
    return restaurantCatalog.fetchCatalog();
  }

  Future<Restaurant>? fetchRestaurant(String alias) async {
    return restaurantData.fetchRestaurant(alias);
  }

  Future<GeneralReviewInfo>? fetchReviews(String alias) async {
    return restaurantReviews.fetchReviews(alias);
  }
}