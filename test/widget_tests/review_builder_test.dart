import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const String reviewText = 'Review Text Here';

  Widget reviewWithAvatar = MaterialApp(
    home: Scaffold(
      body: ListView.builder(
          itemCount: 3,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemBuilder: (_, index) {
            return ListTile(
              title: Column(
                children: [
                  RatingBarIndicator(
                    rating: 4.5,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber.shade600,
                    ),
                    itemCount: 5,
                    unratedColor: Colors.amber.withOpacity(0.5),
                  ),
                  const Text(
                    reviewText,
                  ),
                  Row(
                    children: const [
                      Text(
                        'User Name',
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
    ),
  );

  testWidgets('3 Review Tiles', (tester) async {
    final threeReviews = reviewWithAvatar;
    await tester.pumpWidget(threeReviews);
    await tester.tap(find.byType(ListView));
    await tester.pumpAndSettle();
    expect(find.byType(ListTile), findsWidgets);
    expect(find.text(reviewText), findsNWidgets(3));
  });
}
