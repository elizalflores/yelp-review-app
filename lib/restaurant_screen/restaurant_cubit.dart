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
  late String alias;
  late RestaurantRepository restaurantRepository;

  RestaurantCubit(
      {required this.alias, RestaurantRepository? restRepo})
      : super(RestaurantLoadingState()) {
    restaurantRepository = restRepo ?? RestaurantRepository();
  }

  void load() async {
    emit(RestaurantLoadingState());
    if(alias.isEmpty) {
      emit(RestaurantErrorState());
      return;
    }
    try {
      final restaurant = await restaurantRepository.fetchRestaurant(alias);
      final reviews = await restaurantRepository.fetchReviews(alias);
      if (restaurant == null || reviews == null) {
        emit(RestaurantErrorState());
      } else {
        emit(RestaurantLoadedState(restaurant: restaurant, reviews: reviews));
      }
    } catch (e) {
      emit(RestaurantErrorState());
    }
  }
}
