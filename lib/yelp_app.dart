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
        dividerTheme: const DividerThemeData(
          space: 0.0,
          thickness: 0.0,
          color: Colors.grey,
          indent: 30,
          endIndent: 30,
        ),
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 19.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          bodyText1: TextStyle(
            fontSize: 15.0,
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
          bodyText2: TextStyle(
            fontSize: 15.0,
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.italic,
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
