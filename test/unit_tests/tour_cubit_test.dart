import 'package:yelp_review/services/dependency_locator.dart';
import 'package:yelp_review/services/GraphQL/gql_client.dart';
import 'package:yelp_review/services/restaurant_repository.dart';//Used in REST implementation

import '../mock_repo.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yelp_review/tour_screen/tour_cubit.dart';
import 'package:yelp_review/services/restaurant_catalog.dart';

void main() {
  final mockRepo = MockGQLCall();
  //final mockRepo = MockRESTCall();//REST implementation
  late RestaurantCatalog mockCatalog;

  setUp(
    () {
      getIt.registerSingleton<GraphQLCall>(mockRepo);
      //getIt.registerSingleton<RestaurantRepository>(mockRepo);//REST implementation
      Businesses mockBusinesses = Businesses(
        rating: 4.5,
        price: '\$',
        alias: 'some-test-alias',
        name: 'Mock Restaurant',
        photos: 'Image link',
        distance: 123456.789,
        categories: [
          const Category(
            title: 'Test Title',
          ),
        ],
      );
      mockCatalog = RestaurantCatalog(businesses: [mockBusinesses]);
    },
  );

  blocTest(
    'emits [mockCatalog] in Loaded State',
    build: () {
      when(() => mockRepo.fetchCatalog())
          .thenAnswer((_) => Future.value(mockCatalog));
      return TourCubit();
    },
    act: (TourCubit cubit) => cubit.load(),
    expect: () => [
      isA<TourLoadingState>(),
      isA<TourLoadedState>(),
    ],
  );

  blocTest(
    'emits Error State',
    build: () {
      when(() => mockRepo.fetchCatalog()).thenThrow(() => Exception());
      return TourCubit();
    },
    act: (TourCubit cubit) => cubit.load(),
    expect: () => [
      isA<TourLoadingState>(),
      isA<TourErrorState>(),
    ],
  );
}
