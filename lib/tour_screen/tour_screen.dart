import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yelp_review/restaurant_app_bar.dart';
import 'package:yelp_review/tour_screen/tour_cubit.dart';
import 'package:yelp_review/tour_screen/widgets/tour_builder.dart';
import 'package:yelp_review/tour_screen/widgets/yelp_indicator.dart';

import '../services/dependency_locator.dart';

class TourScreen extends StatefulWidget {

  const TourScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TourScreen> createState() => _TourScreenState();
}

class _TourScreenState extends State<TourScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => TourCubit()..load(),
        child: Container(
          color: const Color(0xFAFAF9F9),
          child: Column(
            children: [
              const RestaurantAppBar(
                title: 'RestauranTour',
                elevation: 3.0,
              ),
              Expanded(
                child: BlocBuilder<TourCubit, TourState>(
                  builder: (context, state) {
                    return YelpIndicator(
                        onRefresh: () async {
                          context.read<TourCubit>().load();
                          return;
                        },
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            if (state is TourLoadingState)
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height / 1.3,
                                child: const Center(
                                    child: CircularProgressIndicator()),
                              ),
                            if (state is TourLoadedState)
                              TourBuilder(
                                catalog: state.catalog,
                              ),
                            if (state is TourErrorState)
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 1.3,
                                child: const Center(
                                  child: Text(
                                      'Oops! Something went wrong. :(',
                                  ),
                                ),
                              ),
                          ],
                        ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
