import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yelp_review/services/dependency_locator.dart';
import 'package:yelp_review/restaurant_screen/restaurant_cubit.dart';
import 'package:yelp_review/services/restaurant_data.dart';
import 'package:yelp_review/services/restaurant_repository.dart';
import 'package:yelp_review/services/restaurant_reviews.dart';

import '../mock_repo.dart';

void main() {
    final mockRepo = MockRESTCall();
    late Restaurant mockRestaurant;
    late GeneralReviewInfo mockReviews;

    setUp(() {
      getIt.registerSingleton<RestaurantRepository>(mockRepo);
      mockRestaurant = Restaurant(
        name: 'Mock Restaurant',
        imageUrl: 'Image Url',
        rating: 4.5,
        price: '\$',
        location: Location(
          displayAddress: const DisplayAddress(
            addressLine1: '123 Some Place St',
            addressLine2: 'Some City, SS 45678',
          ),
        ),
        coordinates: const Coordinates(
            latitude: 1234.0,
            longitude: 56789.0,
        ),
        categories: [
          const Category(
              alias: 'Test Alias',
              title: 'Test Category',
          ),
        ],
        hours: [
          Hours(
            isOpenNow: true,
            restaurantHours: [
              DailyHours(
                isOvernight: false,
                startTime: '0800',
                endTime: '1800',
                day: 0,
              ),
            ],
          ),
        ],
        photos: ['Test photos'],
      );

      mockReviews = GeneralReviewInfo(
        totalReviews: 3,
        individuals: [
          IndividualReviews(
            rating: 3.5,
            reviewText: 'Review Text',
            user: const User(
              name: 'Username',
              imageUrl: 'User Icon',
            ),
          ),
        ],
      );
    });

    blocTest(
      'emits Restaurant Screen in Loaded State',
      build: () {
        when(() => mockRepo.fetchRestaurant(any()))
            .thenAnswer((_) => Future.value(mockRestaurant));
        when(() => mockRepo.fetchReviews(any()))
            .thenAnswer((_) => Future.value(mockReviews));
        return RestaurantCubit();
      },
      act: (RestaurantCubit cubit) => cubit.load(alias: 'test-alias'),
      expect: () => [
            isA<RestaurantLoadingState>(),
            isA<RestaurantLoadedState>(),
          ],
    );

    blocTest(
      'emits Error State',
      build: () {
        when(() => mockRepo.fetchRestaurant(any()))
            .thenThrow((_) => Future.value(mockRestaurant));
        when(() => mockRepo.fetchReviews(any()))
            .thenThrow((_) => Future.value(mockReviews));
        return RestaurantCubit();
      },
      act: (RestaurantCubit cubit) => cubit.load(alias: 'test-alias'),
      expect: () => [
        isA<RestaurantLoadingState>(),
        isA<RestaurantErrorState>(),
      ],
    );
}
