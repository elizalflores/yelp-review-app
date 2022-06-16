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
  String? yelpName = '';

  @override
  void initState() {
    super.initState();
    getRestaurant();
  }

   void getRestaurant() async {
    try{
      final restaurant = await yelpAction.fetchRestaurant();
      print(restaurant.name);
      setState(() {
        yelpName = restaurant.name;
      });
    } catch(e) {
      print(e);
    }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
          ),
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Text(
              yelpName ?? 'This is a Restaurant Name',
              style: const TextStyle(color: Colors.black),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
    );
  }
}
