import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:yelp_review/services/restaurant_catalog.dart';

class TourCardInformation extends StatelessWidget {
  final RestaurantCatalog? catalog;
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
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 20.0,
        ),
        title: Text(
          catalog!.businesses[index].name,
          style: Theme.of(context).textTheme.headline1,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${catalog!.businesses[index].price} ${catalog!.businesses[index].categories.first.title}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: catalog!.businesses[index].rating.toDouble(),
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 15.0,
                        direction: Axis.horizontal,
                        unratedColor: Colors.amber.withOpacity(0.5),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 50.0,
                        ),
                        child: Text(
                          (catalog!.businesses[index].isClosed)
                              ? 'Closed'
                              : 'In business',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 4.0,
                        ),
                        child: Icon(
                          Icons.circle,
                          color: (catalog!.businesses[index].isClosed)
                              ? Colors.red
                              : Colors.green,
                          size: 12.0,
                        ),
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