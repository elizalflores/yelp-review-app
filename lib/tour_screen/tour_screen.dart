import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yelp_review/restaurant_app_bar.dart';
import 'package:yelp_review/services/restaurant_catalog.dart';
import 'package:yelp_review/services/restaurant_repository.dart';
import 'package:yelp_review/tour_screen/tour_cubit.dart';
import 'package:yelp_review/tour_screen/widgets/tour_builder.dart';
import 'package:yelp_review/tour_screen/widgets/tour_card.dart';

class TourScreen extends StatefulWidget {
  const TourScreen({Key? key}) : super(key: key);

  @override
  State<TourScreen> createState() => _TourScreenState();
}

class _TourScreenState extends State<TourScreen> {
  /*final restaurantRepository = RestaurantRepository();
  Future<RestaurantCatalog>? futureCatalog;*/

  /*@override
  void initState() {
    super.initState();
    _load();
  }*/

  /*_load() async {
    futureCatalog = restaurantRepository.fetchCatalog();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFAFAF9F9),
        child: Column(
          children: [
            const RestaurantAppBar(
              title: 'RestauranTour',
              elevation: 3.0,
            ),
            Expanded(
              child: BlocProvider(
                create: (_) => TourCubit(),
                child: BlocBuilder<TourCubit, TourState>(
                  builder: (context, state) {
                    if (state is TourErrorState) {
                      return SizedBox(
                          height: MediaQuery.of(context).size.height * .7,
                          child: const Center(
                              child: Text(
                                'Oops! Something went wrong. :(',
                              )
                          )
                      );
                    }
                    if (state is TourLoadedState) {
                      return TourBuilder(catalog: state.catalog);
                    } else if (state is TourLoadingState) {
                      return const Center(
                          child: CircularProgressIndicator(),
                      );
                    }

                    return const Scaffold(
                      body: Center(
                        child: Text('Oops! Something went wrong. :('),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
