import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yelp_review/services/restaurant_catalog.dart';
import 'package:yelp_review/services/restaurant_repository.dart';

abstract class TourState {}

class TourErrorState extends TourState {}

class TourLoadingState extends TourState {}

class TourLoadedState extends TourState {
  RestaurantCatalog catalog;

  TourLoadedState({
    required this.catalog,
});

}

class TourCubit extends Cubit<TourState> {
  RestaurantRepository restaurantRepository = RestaurantRepository();

  TourCubit() : super(TourLoadingState()) {
    load();
  }

  void load() async {
    try {
      final catalog = await restaurantRepository.fetchCatalog();
      if(catalog.businesses.isEmpty) {
        emit(TourErrorState());
      } else {
        emit(TourLoadedState(catalog: catalog,));
      }
    } catch (e) {
      emit(TourErrorState());
    }

  }
}

