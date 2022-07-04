import 'package:flutter/material.dart';
import 'package:yelp_review/services/restaurant_catalog.dart';
import 'package:yelp_review/tour_screen/widgets/tour_card_image.dart';
import 'package:yelp_review/tour_screen/widgets/tour_card_information.dart';

class TourCard extends StatelessWidget {
  final RestaurantCatalog? catalog;
  final int index;

  const TourCard({
    Key? key,
    required this.catalog,
    required this.index,
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 6.0,
        ),
        color: Colors.white,
        elevation: 1.0,
        child: InkWell(
          splashColor: Colors.lightBlueAccent,
          onTap: (){
            Navigator.of(context).pushNamed(
                '/restaurant_screen',
                arguments: catalog!.businesses[index].alias
            );
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0,
                    right: 0.0,
                    top: 10.0,
                    bottom: 10.0,
                ),
                child: TourCardImage(
                  imageUrl: catalog!.businesses[index].imageUrl,
                  index: index,
                ),
              ),
              TourCardInformation(
                catalog: catalog,
                index: index,
              ),
            ],
          ),
        ),
      );
  }
}