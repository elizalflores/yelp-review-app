import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:yelp_review/restaurant_app_bar.dart';
import 'package:yelp_review/services/restaurant_catalog.dart';
import 'package:yelp_review/services/restaurant_repository.dart';

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
    //print(futureCatalog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFAFAF9F9),
        child: Column(
          children: [
            const RestaurantAppBar(title: 'RestauranTour', elevation: 3.0,),
            Expanded(
              child: ListView(
                children: [
                  FutureBuilder<RestaurantCatalog>(
                    future: futureCatalog,
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        return ListView.builder(
                          itemCount: snapshot.data!.businesses.length,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (_, index) {
                              return Card(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 12.0,
                                    vertical: 6.0,
                                ),
                                color: Colors.white,
                                elevation: 1.0,
                                child: InkWell(
                                  onTap: (){
                                    Navigator.of(context).pushNamed('/restaurant_screen', arguments: snapshot.data!.businesses[index].alias);
                                  },
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: SizedBox(
                                          width: 100,
                                          height: 100,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10.0),
                                            child: Image.network(
                                              snapshot.data!.businesses[index].imageUrl,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 10.0,
                                            vertical: 20.0,
                                          ),
                                          title: Text(
                                            snapshot.data!.businesses[index].name,
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
                                                      '${snapshot.data!.businesses[index].price} ${snapshot.data!.businesses[index].categories.first.title}',
                                                      style: Theme.of(context).textTheme.bodyText1,
                                                    ),
                                                    Row(
                                                      children: [
                                                        RatingBarIndicator(
                                                          rating: snapshot.data!.businesses[index].rating.toDouble(),
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
                                                            (snapshot.data!.businesses[index].isClosed)
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
                                                            color: (snapshot.data!.businesses[index].isClosed)
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
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                        );
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

/*class TourTile extends StatelessWidget {
  const TourTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}*/
