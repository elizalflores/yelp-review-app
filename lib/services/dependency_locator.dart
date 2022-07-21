import 'package:get_it/get_it.dart';
import 'package:yelp_review/restaurant_screen/restaurant_cubit.dart';
import 'package:yelp_review/services/GraphQL/gql_client.dart';
import 'package:yelp_review/services/restaurant_repository.dart';
import 'package:yelp_review/tour_screen/tour_cubit.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.allowReassignment = true;
  getIt.registerSingleton<RestaurantRepository>(RestaurantRepository());
  getIt.registerSingleton<RestaurantCubit>(RestaurantCubit());
  getIt.registerSingleton<GraphQLCall>(GraphQLCall());
  getIt.registerSingleton<TourCubit>(TourCubit());
}

void testSetup() {
  getIt.allowReassignment = true;
}