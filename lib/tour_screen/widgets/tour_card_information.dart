import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:yelp_review/services/restaurant_catalog.dart';
import 'package:yelp_review/tour_screen/widgets/tour_card_image.dart';

class TourCardInformation extends StatelessWidget {
  final RestaurantCatalog catalog;
  final int index;

  const TourCardInformation({
    Key? key,
    required this.catalog,
    required this.index,
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListTile(
        minVerticalPadding: 0,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        title: SizedBox(
          height: imageSize / 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                catalog.businesses[index].name,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        subtitle: SizedBox(
          height: imageSize / 2,
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  catalog.businesses[index].price != null ?
                    Text(
                      '${catalog.businesses[index].price} ${catalog.businesses[index].categories.first.title}',
                      style: Theme.of(context).textTheme.bodyText1,
                    ) : Text(
                    '\$ ${catalog.businesses[index].categories.first.title}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: catalog.businesses[index].rating.toDouble(),
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber.shade600,
                        ),
                        itemCount: 5,
                        itemSize: 15.0,
                        direction: Axis.horizontal,
                        unratedColor: Colors.amber.withOpacity(0.5),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 110.0,
                        ),
                        child:
                        catalog.businesses[index].distance != null ?
                        Text(
                          '${convertDistance(catalog.businesses[index].distance!)} mi',
                          style: Theme.of(context).textTheme.bodyText2,
                        )
                        : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String convertDistance(num meters) {
  final miles = meters / 1609.344;

  return miles.toStringAsFixed(1);
}