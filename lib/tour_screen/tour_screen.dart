import 'package:flutter/material.dart';
import 'package:yelp_review/restaurant_app_bar.dart';
import 'package:yelp_review/services/restaurant_catalog.dart';
import 'package:yelp_review/services/restaurant_repository.dart';
import 'package:yelp_review/tour_screen/widgets/tour_card.dart';

class TourScreen extends StatefulWidget {
  const TourScreen({Key? key}) : super(key: key);

  @override
  State<TourScreen> createState() => _TourScreenState();
}

class _TourScreenState extends State<TourScreen> {
  final restaurantRepository = RestaurantRepository();
  Future<RestaurantCatalog>? futureCatalog;

  @override
  void initState() {
    super.initState();
    _load();
  }

  _load() async {
    futureCatalog = restaurantRepository.fetchCatalog();
  }

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
              child: ListView(
                children: [
                  FutureBuilder<RestaurantCatalog>(
                    future: futureCatalog,
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        final catalog = snapshot.data;
                        return ListView.builder(
                          itemCount: catalog!.businesses.length,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (_, index) {
                              return TourCard(
                                catalog: catalog,
                                index: index,
                              );
                            }
                        );
                      } else if (snapshot.hasError) {
                        return const Center(child: Text('Oops, something went wrong'));
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

