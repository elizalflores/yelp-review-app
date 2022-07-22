import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:yelp_review/main.dart';
import 'package:yelp_review/services/dependency_locator.dart';
import 'package:yelp_review/services/GraphQL/gql_client.dart';
import 'package:yelp_review/tour_screen/tour_screen.dart';

import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yelp_review/services/restaurant_catalog.dart';

import '../mock_repo.dart';


void main() {
  final mockRepo = MockGQLCall();
  late RestaurantCatalog mockCatalog;

  setUp(
        () {
      getIt.registerSingleton<GraphQLCall>(mockRepo);
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

  tearDown(() {
    mockLoading = false;
  });

  testGoldens(
    'Loading Screen',
        (tester) async {
      mockLoading = true;

      when(() => mockRepo.fetchCatalog()).thenAnswer((_) => Future.value(mockCatalog));

      final builder = DeviceBuilder();

      builder.addScenario(
        name: 'Loaded',
        widget: const TourScreen(),
      );

      await tester.pumpDeviceBuilder(builder);

      await screenMatchesGolden(tester, 'tour_loading_screen');
    },
  );

  testGoldens(
    'Loaded Screen',
        (tester) async {
      when(() => mockRepo.fetchCatalog()).thenAnswer((_) => Future.value(mockCatalog));

      final builder = DeviceBuilder();

      builder.addScenario(
        name: 'Loaded',
        widget: const TourScreen(),
      );

      await tester.pumpDeviceBuilder(builder);

      await screenMatchesGolden(tester, 'tour_loaded_screen');
    },
  );

  testGoldens(
    'Error Screen',
        (tester) async {
      when(() => mockRepo.fetchCatalog()).thenThrow(Error());

      final builder = DeviceBuilder();

      builder.addScenario(
        name: 'Error',
        widget: const TourScreen(),
      );

      await tester.pumpDeviceBuilder(builder);

      await screenMatchesGolden(tester, 'tour_error_screen');
    },
  );
}
