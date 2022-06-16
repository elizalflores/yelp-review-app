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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.0),
          child: Text(
            'This is a Restaurant Name',
            style: TextStyle(color: Colors.black),
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
