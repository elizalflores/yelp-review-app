import 'mock_repo.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yelp_review/tour_screen/tour_cubit.dart';
import 'package:yelp_review/services/restaurant_catalog.dart';

void main() {
  final mockRepo = MockGQLCall();
  late RestaurantCatalog mockCatalog;

  setUp(
    () {
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
    'emits Error State',
    build: () {
      //mock error state
      when(() => mockRepo.fetchCatalog()).thenThrow(() => Exception());
      return TourCubit(catalogCall: mockRepo);
    },
    act: (TourCubit cubit) => cubit.load(),
    expect: () => [
      isA<TourLoadingState>(),
      isA<TourErrorState>(),
    ],
  );

  blocTest(
    'emits [mockCatalog] in Loaded State',
    build: () {
      //mock loaded state
      when(() => mockRepo.fetchCatalog())
          .thenAnswer((_) => Future.value(mockCatalog));
      return TourCubit(catalogCall: mockRepo);
    },
    act: (TourCubit cubit) => cubit.load(),
    expect: () => [
      isA<TourLoadingState>(),
      isA<TourLoadedState>(),
    ],
  );
}
