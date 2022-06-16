import 'package:flutter/material.dart';
import 'package:yelp_review/home_screen.dart';

class YelpApp extends StatelessWidget {
  const YelpApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home_screen',
      routes: {
        '/home_screen': (context) => const HomeScreen(),
      },
    );
  }
}