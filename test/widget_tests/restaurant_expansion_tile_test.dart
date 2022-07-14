import 'package:flutter/material.dart';
import 'package:yelp_review/restaurant_screen/widgets/restaurant_expansion_tile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yelp_review/services/restaurant_data.dart';

void main() {
  Widget expansionTileWithHours = MaterialApp(
        home: Scaffold(
          body: RestaurantExpansionTile(
          price: '\$',
          title: 'Food Category',
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
          paddingAmount: 30,
            ),
        ),
      );

  Widget expansionTileWithoutHours = const MaterialApp(
    home: Scaffold(
      body: RestaurantExpansionTile(
        price: '\$',
        title: 'Food Category',
        hours: null,
        paddingAmount: 30,
      ),
    ),
  );

  testWidgets('When Hours is not null', (tester) async {
    final tile = expansionTileWithHours;
    await tester.pumpWidget(tile);
    await tester.tap(find.byType(RestaurantExpansionTile));
    await tester.pumpAndSettle();
    expect(find.text('08:00 AM - 06:00 PM'), findsWidgets);
    expect(find.byKey(const Key('Monday')), findsOneWidget);
  });

  testWidgets('When Hours is null', (tester) async {
    final tile = expansionTileWithoutHours;
    await tester.pumpWidget(tile);
    await tester.tap(find.byType(RestaurantExpansionTile));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('Monday')), findsNothing);
  });
}
