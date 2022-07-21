import 'package:bloc_test/bloc_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:yelp_review/services/dependency_locator.dart';
import 'package:yelp_review/services/GraphQL/gql_client.dart';
import 'package:yelp_review/tour_screen/tour_cubit.dart';
import 'package:yelp_review/tour_screen/tour_screen.dart';

import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yelp_review/services/restaurant_catalog.dart';

import '../mock_repo.dart';

class MockTourCubit extends Mock implements TourCubit {
  @override
  Future<void> close() {
    return Future.value();
  }
}

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

  testGoldens(
    'Loading Screen',
        (tester) async {
      MockTourCubit mockCubit = MockTourCubit();
      getIt.registerSingleton<TourCubit>(mockCubit);
      when(() => mockCubit.state).thenAnswer((_) => TourLoadingState());

      final builder = DeviceBuilder();

      whenListen(
        mockCubit,
        Stream.fromIterable(
          [
            TourLoadingState(),
          ],
        ),
        initialState: TourLoadingState(),
      );

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
      MockTourCubit mockCubit = MockTourCubit();
      getIt.registerSingleton<TourCubit>(mockCubit);
      //when(() => mockCubit.load()).thenAnswer((_) async {});

      final builder = DeviceBuilder();

      whenListen(
        mockCubit,
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
        widget: const TourScreen(),
      );

      await tester.pumpDeviceBuilder(builder);

      await screenMatchesGolden(tester, 'tour_loaded_screen');
    },
  );

  testGoldens(
    'Error Screen',
        (tester) async {
      MockTourCubit mockCubit = MockTourCubit();
      getIt.registerSingleton<TourCubit>(mockCubit);
      when(() => mockCubit.load()).thenAnswer((_) async {});

      final builder = DeviceBuilder();

      whenListen(
        mockCubit,
        Stream.fromIterable(
          [
            TourLoadingState(),
            TourErrorState(),
          ],
        ),
        initialState: TourLoadingState(),
      );

      builder.addScenario(
        name: 'Error',
        widget: const TourScreen(),
      );

      await tester.pumpDeviceBuilder(builder);

      await screenMatchesGolden(tester, 'tour_error_screen');
    },
  );
}
