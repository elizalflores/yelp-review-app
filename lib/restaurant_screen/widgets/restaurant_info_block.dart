import 'package:flutter/material.dart';
import 'package:yelp_review/restaurant_screen/widgets/google_map_window.dart';
import 'package:yelp_review/restaurant_screen/widgets/yelp_divider.dart';
import 'package:yelp_review/services/restaurant_data.dart';


class RestaurantInfoBlock extends StatelessWidget {
  final String name;
  final DisplayAddress? address;
  final double? rating;
  final double paddingAmount;
  final Coordinates coordinates;

  const RestaurantInfoBlock({
    Key? key,
    required this.name,
    required this.address,
    this.rating,
    required this.paddingAmount,
    required this.coordinates,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Text(
            'Address',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: paddingAmount,
            bottom: paddingAmount,
          ),
          child: Text(
            '${address!.addressLine1}\n'
            '${address!.addressLine2}',
            style: const TextStyle(
              height: 1.5,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: paddingAmount,
            right: paddingAmount,
            bottom: paddingAmount,
          ),
          child: GoogleMapWindow(
            restaurantName: name,
            coordinates: coordinates,
          ),
        ),
        const YelpDivider(),
        Padding(
          padding: EdgeInsets.only(
            top: paddingAmount,
            left: paddingAmount,
            bottom: 20.0,
          ),
          child: Text(
            'Overall Rating',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: paddingAmount,
            left: paddingAmount,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                rating != null ? rating!.toStringAsFixed(1) : '0.0',
                style: const TextStyle(
                  fontSize: 35.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                ),
              ),
              Transform(
                transform: Matrix4.translationValues(0.0, 2.0, 0.0),
                child: const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 20.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
