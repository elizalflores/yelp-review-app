import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:yelp_review/restaurant_screen/widgets/yelp_divider.dart';
import 'package:yelp_review/services/restaurant_reviews.dart';

import '../../main.dart';

class ReviewBuilder extends StatelessWidget {
  final GeneralReviewInfo? reviews;
  final double paddingAmount;

  const ReviewBuilder({
    Key? key,
    required this.reviews,
    required this.paddingAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: reviews!.individuals.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (_, index) {
        return ListTile(
          contentPadding: const EdgeInsets.only(
            top: 12.0,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RatingBarIndicator(
                rating: reviews!.individuals[index].rating.toDouble(),
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.amber.shade600,
                ),
                itemCount: 5,
                itemSize: 15.0,
                direction: Axis.horizontal,
                unratedColor: Colors.amber.withOpacity(0.5),
                itemPadding: const EdgeInsets.only(
                  bottom: 10.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: paddingAmount,
                ),
                child: Text(
                  reviews!.individuals[index].reviewText,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 12.0,
                  bottom: 20.0,
                ),
                child: Row(
                  children: [
                    if (isTestMode != true && reviews!.individuals[index].user.imageUrl != null) ...[
                      Avatar(
                        sources: [
                          NetworkSource(
                              reviews!.individuals[index].user.imageUrl!),
                        ],
                        shape: AvatarShape.circle(20),
                      ),
                    ] else if (isTestMode == true) ...[
                      const Icon(
                        Icons.circle,
                        size: 20,
                        color: Colors.red,
                      ),
                    ] else ...[
                      Avatar(
                        name: reviews!.individuals[index].user.name,
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: AvatarShape.circle(20),
                      ),
                    ],
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        reviews!.individuals[index].user.name,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ],
                ),
              ),
              const YelpDivider(
                indents: 0.0,
              ),
            ],
          ),
        );
      },
    );
  }
}
