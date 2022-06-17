import 'package:flutter/material.dart';
import 'package:yelp_review/home_screen.dart';

class YelpApp extends StatelessWidget {
  const YelpApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.white,
        fontFamily: 'Georgia',
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 19.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          bodyText1: TextStyle(
            fontSize: 14.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      initialRoute: '/home_screen',
      routes: {
        '/home_screen': (context) => const HomeScreen(),
      },
    );
  }
}
