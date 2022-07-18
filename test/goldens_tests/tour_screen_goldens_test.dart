import 'package:bloc_test/bloc_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:yelp_review/main.dart';
import 'package:yelp_review/tour_screen/tour_cubit.dart';
import 'package:yelp_review/tour_screen/tour_screen.dart';

import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yelp_review/services/restaurant_catalog.dart';

class MockTourCubit extends MockCubit<TourState> implements TourCubit {}

void main() {
  late RestaurantCatalog mockCatalog;

  setUp(
        () {
          isTestMode = true;
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

  testGoldens(
    'Loading Screen',
        (tester) async {
      MockTourCubit mockTour = MockTourCubit();
      when(() => mockTour.load()).thenAnswer((_) async {});

      final builder = DeviceBuilder();

      whenListen(
        mockTour,
        Stream.fromIterable(
          [
            TourLoadingState(),
            TourLoadedState(catalog: mockCatalog),
          ],
        ),
        initialState: TourLoadingState(),
      );

      builder.addScenario(
        name: 'Loaded',
        widget: TourScreen(cubit: mockTour),
      );

      await tester.pumpDeviceBuilder(builder);

      await screenMatchesGolden(tester, 'tour_loaded_screen');
    },
  );
}
