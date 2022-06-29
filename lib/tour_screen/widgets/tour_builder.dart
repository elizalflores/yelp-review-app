import 'package:flutter/material.dart';
import 'package:yelp_review/services/restaurant_catalog.dart';
import 'package:yelp_review/tour_screen/widgets/tour_card.dart';


class TourBuilder extends StatelessWidget {
  final RestaurantCatalog? catalog;

  const TourBuilder({Key? key, required this.catalog,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: catalog!.businesses.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (_, index) {
          return TourCard(
            catalog: catalog,
            index: index,
          );
        }
    );
  }
}