import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yelp_review/services/restaurant_data.dart';
import 'package:yelp_review/services/restaurant_repository.dart';
import 'package:yelp_review/services/restaurant_reviews.dart';

abstract class RestaurantState {}

class RestaurantErrorState extends RestaurantState {}

class RestaurantLoadingState extends RestaurantState {}

class RestaurantLoadedState extends RestaurantState {
  Restaurant restaurant;
  GeneralReviewInfo reviews;

  RestaurantLoadedState({
    required this.restaurant,
    required this.reviews,
  });

}

class RestaurantCubit extends Cubit<RestaurantState> {
  RestaurantRepository restaurantRepository = RestaurantRepository();
  final String alias;

  RestaurantCubit({required this.alias}) : super(RestaurantLoadingState()) {
    load(alias);
  }

  void load(String alias) async {
    try {
      final restaurant = await restaurantRepository.fetchRestaurant(alias);
      final reviews = await restaurantRepository.fetchReviews(alias);
      if(restaurant == null || reviews == null) {
        emit(RestaurantErrorState());
      } else {
        emit(RestaurantLoadedState(restaurant: restaurant, reviews: reviews));
      }
    } catch (e) {
      emit(RestaurantErrorState());
    }
  }
}

