import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yelp_review/api_calls.dart';

class HomeScreen extends StatefulWidget {
  final String? restaurantName;

  const HomeScreen({@visibleForTesting this.restaurantName, Key? key})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final yelpAction = YelpCall();
  Future<Restaurant>? futureRestaurant;

  @override
  void initState() {
    super.initState();
    getRestaurant();
  }

  void getRestaurant() async {
    try {
      futureRestaurant = yelpAction.fetchRestaurant();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Restaurant>(
        future: futureRestaurant,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: Theme.of(context).primaryColor,
              body: ListView(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppBar(
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Theme.of(context).primaryColor.withOpacity(.5),
                      statusBarIconBrightness: Theme.of(context).brightness,
                    ),
                    title: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Text(
                        snapshot.data?.name ?? 'This is a Restaurant Name',
                        style: Theme.of(context).textTheme.headline1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    centerTitle: true,
                    backgroundColor: Theme.of(context).primaryColor,
                    elevation: 0,
                  ),
                  snapshot.data?.imageUrl != null &&
                          snapshot.data!.imageUrl.isNotEmpty
                      ? Image.network(
                          snapshot.data!.imageUrl,
                          fit: BoxFit.contain,
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
