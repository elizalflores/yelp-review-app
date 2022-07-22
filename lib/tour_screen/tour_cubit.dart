import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yelp_review/services/GraphQL/gql_client.dart';
import 'package:yelp_review/services/restaurant_catalog.dart';
import'package:yelp_review/services/restaurant_repository.dart';//Used in REST Implementation

import '../main.dart';
import '../services/dependency_locator.dart';

abstract class TourState {}

class TourErrorState extends TourState {}

class TourLoadingState extends TourState {}

class TourLoadedState extends TourState {
  RestaurantCatalog? catalog;

  TourLoadedState({
    required this.catalog,
  });
}

class TourCubit extends Cubit<TourState> {
  //GraphQL Implementation
  GraphQLCall catalogCall = getIt<GraphQLCall>();

  //REST Implementation
  //RestaurantRepository restaurantRepository = getIt<RestaurantRepository>();

  TourCubit() : super(TourLoadingState());

  void load() async {
    if (mockLoading) {
      emit(TourLoadingState());
      return;
    }
    emit(TourLoadingState());
    try {
      //GraphQL Implementation
      final catalog = await catalogCall.fetchCatalog();

      //REST Implementation
      //final catalog = await restaurantRepository.fetchCatalog();

      if (catalog.businesses.isEmpty) {
        emit(TourErrorState());
      } else {
        if(catalog.businesses.first.distance != null) {
          catalog.businesses.sort(
            (a, b) => a.distance!.compareTo(b.distance!),
          );
        }
        emit(TourLoadedState(catalog: catalog));
      }
    } catch (e) {
      emit(TourErrorState());
    }
  }
}
