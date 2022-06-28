import 'package:flutter/material.dart';
import 'package:yelp_review/restaurant_screen/widgets/restaurant_expansion_tile.dart';
import 'package:yelp_review/restaurant_screen/widgets/restaurant_image_carousel.dart';
import 'package:yelp_review/restaurant_screen/widgets/restaurant_info_block.dart';
import 'package:yelp_review/restaurant_screen/widgets/review_builder.dart';
import 'package:yelp_review/restaurant_screen/widgets/yelp_divider.dart';
import 'package:yelp_review/services/restaurant_data.dart';
import 'package:yelp_review/services/restaurant_repository.dart';
import 'package:yelp_review/services/restaurant_reviews.dart';
import 'package:yelp_review/restaurant_app_bar.dart';

class RestaurantScreen extends StatefulWidget {
  final String? restaurantName;
  final String alias;

  const RestaurantScreen(
      {@visibleForTesting this.restaurantName, required this.alias, Key? key})
      : super(key: key);

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  final DividerThemeData dividerTheme = const DividerThemeData();
  static const double paddingAmount = 30.0;

  Future<Restaurant>? futureRestaurant;
  Future<GeneralReviewInfo>? futureReviews;
  final restaurantRepository = RestaurantRepository();


  @override
  void initState() {
    super.initState();
    getRestaurant(widget.alias);
  }

  void getRestaurant(String alias) async {
    try {
      futureRestaurant = restaurantRepository.fetchRestaurant(alias);
      futureReviews = restaurantRepository.fetchReviews(alias);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body:
          FutureBuilder<Restaurant>(
            future: futureRestaurant,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                final restaurant = snapshot.data;
                final rating = snapshot.data?.rating;
                final address = snapshot.data?.location.displayAddress;
                return ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RestaurantAppBar(
                          title: restaurant!.name,
                        ),
                        RestaurantImageCarousel(photos: restaurant.photos),
                        RestaurantExpansionTile(
                          price: restaurant.price,
                          title: restaurant.categories.first.title,
                          hours: restaurant.hours,
                          paddingAmount: paddingAmount,
                        ),
                        const YelpDivider(),
                        RestaurantInfoBlock(
                          address: address,
                          rating: rating,
                          paddingAmount: paddingAmount,
                        ),
                        const YelpDivider(),
                        FutureBuilder<GeneralReviewInfo>(
                          future: futureReviews,
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data != null) {
                              final reviews = snapshot.data;
                              return Padding(
                                padding: const EdgeInsets.only(
                                  left: paddingAmount,
                                  top: paddingAmount,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${snapshot.data?.totalReviews ?? 0} Reviews',
                                      style: Theme.of(context).textTheme.bodyText1,
                                    ),
                                    ReviewBuilder(
                                      reviews: reviews,
                                      paddingAmount: paddingAmount,
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return const Text('Oops, it\'s Matt\'s fault');
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
    );
  }
}
