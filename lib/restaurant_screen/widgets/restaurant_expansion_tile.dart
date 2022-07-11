import 'package:flutter/material.dart';
import 'package:yelp_review/restaurant_screen/widgets/restaurant_time.dart';
import 'package:yelp_review/services/restaurant_data.dart';

class RestaurantExpansionTile extends StatelessWidget {
  final String? price;
  final String title;
  final List<Hours>? hours;
  final double paddingAmount;

  const RestaurantExpansionTile({
    Key? key,
    required this.price,
    required this.title,
    required this.hours,
    required this.paddingAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.only(
        left: paddingAmount,
        right: paddingAmount,
      ),
      childrenPadding: const EdgeInsets.only(
        left: 15.0,
      ),
      collapsedIconColor: Colors.grey,
      iconColor: Colors.grey,
      title: Row(
        children: [
          price != null ?
          Text(
            '$price $title',
            style: Theme.of(context).textTheme.bodyText1,
          ) :
          Text(
            '\$ $title',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const Spacer(),
          Text(
            (hours?.first.isOpenNow ?? false) ? 'Open Now' : 'Closed',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 4.0,
              right: 4.0,
            ),
            child: Icon(
              Icons.circle,
              color:
                  (hours?.first.isOpenNow ?? false) ? Colors.green : Colors.red,
              size: 12.0,
            ),
          ),
        ],
      ),
      children: [
        if (hours != null && hours!.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: ListTile(
              title: RestaurantTime(hours!.first.restaurantHours),
            ),
          ),
        ] else ...[
          const Padding(
            padding: EdgeInsets.only(bottom: 10.0,),
            child: ListTile(
              title: Text(
                'Hours\n'
                'No Hours Listed',
                style: TextStyle(
                  height: 1.5,
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ),
        ]
      ],
    );
  }
}
