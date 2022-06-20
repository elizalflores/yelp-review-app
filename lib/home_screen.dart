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
  final DividerThemeData dividerTheme = const DividerThemeData();
  static const double _paddingAmount = 30.0;
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
              children: [
                AppBar(
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Theme.of(context).primaryColor,
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
                Padding(
                  padding: const EdgeInsets.all(_paddingAmount),
                  child: Row(
                    children: [
                      Text(
                        '${snapshot.data!.price} ${snapshot.data!.categories.first.title}',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const Spacer(),
                      Text(
                        (snapshot.data!.hours.first.isOpenNow)
                            ? 'Open Now'
                            : 'Closed',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 4.0,
                        ),
                        child: Icon(
                          Icons.circle,
                          color: (snapshot.data!.hours.first.isOpenNow)
                              ? Colors.green
                              : Colors.red,
                          size: 12.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: dividerTheme.space,
                  thickness: dividerTheme.thickness,
                  color: dividerTheme.color,
                  indent: dividerTheme.indent,
                  endIndent: dividerTheme.endIndent,
                ),
                Padding(
                  padding: const EdgeInsets.all(_paddingAmount),
                  child: Text(
                    'Address',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: _paddingAmount,
                    bottom: _paddingAmount,
                  ),
                  child: Text(
                    '${snapshot.data?.location.displayAddress.addressLine1}\n'
                    '${snapshot.data?.location.displayAddress.addressLine2}',
                    style: const TextStyle(
                      height: 1.5,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(
                  height: dividerTheme.space,
                  thickness: dividerTheme.thickness,
                  color: dividerTheme.color,
                  indent: dividerTheme.indent,
                  endIndent: dividerTheme.endIndent,
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

/*
Expanded(
  child: Container(
    color: Colors.green,
    height: 100.0,
    width: 100.0,
  ),
),
*/
