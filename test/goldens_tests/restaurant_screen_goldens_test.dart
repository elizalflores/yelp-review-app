import 'package:bloc_test/bloc_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:yelp_review/services/dependency_locator.dart';
import 'package:yelp_review/restaurant_screen/restaurant_cubit.dart';

import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yelp_review/restaurant_screen/restaurant_screen.dart';
import 'package:yelp_review/services/restaurant_data.dart';
import 'package:yelp_review/services/restaurant_repository.dart';
import 'package:yelp_review/services/restaurant_reviews.dart';

import '../mock_repo.dart';

class MockRestaurantCubit extends Mock implements RestaurantCubit {
  @override
  Future<void> close() {
    return Future.value();
  }
}

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

  testGoldens(
    'Loading Screen',
        (tester) async {
      MockRestaurantCubit mockCubit = MockRestaurantCubit();
      getIt.registerSingleton<RestaurantCubit>(mockCubit);
      when(() => mockCubit.state).thenAnswer((_) => RestaurantLoadingState());

      final builder = DeviceBuilder();

      whenListen(
        mockCubit,
        Stream.fromIterable(
          [
            RestaurantLoadingState(),
          ],
        ),
        initialState: RestaurantLoadingState(),
      );

      builder.addScenario(
        name: 'Loaded',
        widget: RestaurantScreen(alias: mockRestaurant.categories.first.alias,),
      );

      await tester.pumpDeviceBuilder(builder);

      await screenMatchesGolden(tester, 'restaurant_loading_screen');
    },
  );

  testGoldens(
    'Loaded Screen',
        (tester) async {
      MockRestaurantCubit mockCubit = MockRestaurantCubit();
      getIt.registerSingleton<RestaurantCubit>(mockCubit);
      when(() => mockCubit.load(alias: any(named:'alias'))).thenAnswer((_) async {});

      final builder = DeviceBuilder();

      whenListen(
        mockCubit,
        Stream.fromIterable(
          [
            RestaurantLoadingState(),
            RestaurantLoadedState(
              restaurant: mockRestaurant,
              reviews: mockReviews,
            ),
          ],
        ),
        initialState: RestaurantLoadingState(),
      );

      builder.addScenario(
        name: 'Loaded',
        widget: RestaurantScreen(alias: mockRestaurant.categories.first.alias,),
      );

      await tester.pumpDeviceBuilder(builder);

      await screenMatchesGolden(tester, 'restaurant_loaded_screen');
    },
  );

  testGoldens(
    'Error Screen',
        (tester) async {
      MockRestaurantCubit mockCubit = MockRestaurantCubit();
      getIt.registerSingleton<RestaurantCubit>(mockCubit);
      when(() => mockCubit.load(alias: any(named:'alias'))).thenAnswer((_) async {});

      final builder = DeviceBuilder();

      whenListen(
        mockCubit,
        Stream.fromIterable(
          [
            RestaurantLoadingState(),
            RestaurantErrorState(),
          ],
        ),
        initialState: RestaurantLoadingState(),
      );

      builder.addScenario(
        name: 'Error',
        widget: RestaurantScreen(alias: mockRestaurant.categories.first.alias,),
      );

      await tester.pumpDeviceBuilder(builder);

      await screenMatchesGolden(tester, 'restaurant_error_screen');
    },
  );
}
