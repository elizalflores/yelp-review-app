import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yelp_review/services/GraphQL/gql_client.dart';
import 'package:yelp_review/services/restaurant_catalog.dart';
import'package:yelp_review/services/restaurant_repository.dart';//Used in REST Implementation

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
  late GraphQLCall catalogCall;

  //REST Implementation
  //RestaurantRepository restaurantRepository = RestaurantRepository();

  TourCubit({GraphQLCall? catalogCall}) : super(TourLoadingState()) {
    this.catalogCall = catalogCall ?? GraphQLCall();
  }

  void load() async {
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
