import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yelp_review/restaurant_screen/restaurant_cubit.dart';
import 'package:yelp_review/restaurant_screen/widgets/restaurant_expansion_tile.dart';
import 'package:yelp_review/restaurant_screen/widgets/restaurant_image_carousel.dart';
import 'package:yelp_review/restaurant_screen/widgets/restaurant_info_block.dart';
import 'package:yelp_review/restaurant_screen/widgets/review_builder.dart';
import 'package:yelp_review/restaurant_screen/widgets/yelp_divider.dart';
import 'package:yelp_review/restaurant_app_bar.dart';

class RestaurantScreen extends StatefulWidget {
  final String? testName;
  final String alias;

  const RestaurantScreen(
      {@visibleForTesting this.testName, required this.alias, Key? key})
      : super(key: key);

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  static const double paddingAmount = 30.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: BlocProvider(
        create: (_) => RestaurantCubit(alias: widget.alias)..load(),
        child: BlocBuilder<RestaurantCubit, RestaurantState>(
          builder: (context, state) {
            if (state is RestaurantLoadedState) {
              return ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RestaurantAppBar(
                        title: state.restaurant.name,
                      ),
                      RestaurantImageCarousel(photos: state.restaurant.photos),
                      RestaurantExpansionTile(
                        price: state.restaurant.price,
                        title: state.restaurant.categories.first.title,
                        hours: state.restaurant.hours,
                        paddingAmount: paddingAmount,
                      ),
                      const YelpDivider(),
                      RestaurantInfoBlock(
                        name: state.restaurant.name,
                        address: state.restaurant.location.displayAddress,
                        coordinates: state.restaurant.coordinates,
                        rating: state.restaurant.rating,
                        paddingAmount: paddingAmount,
                      ),
                      const YelpDivider(),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: paddingAmount,
                          top: paddingAmount,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${state.reviews.totalReviews ?? 0} Reviews',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            ReviewBuilder(
                              reviews: state.reviews,
                              paddingAmount: paddingAmount,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else if (state is RestaurantErrorState) {
              return const Center(child: Text('Oops, something went wrong'));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
