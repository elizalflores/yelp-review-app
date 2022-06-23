import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yelp_review/api_calls.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:avatars/avatars.dart';

class HomeScreen extends StatefulWidget {
  final String? restaurantName;

  const HomeScreen({@visibleForTesting this.restaurantName, Key? key})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final yelpAction = YelpCall();
  final reviewAction = ReviewsCall();
  final DividerThemeData dividerTheme = const DividerThemeData();
  static const double _paddingAmount = 30.0;
  Future<Restaurant>? futureRestaurant;
  Future<GeneralReviewInfo>? futureReviews;

  @override
  void initState() {
    super.initState();
    getRestaurant();
  }

  void getRestaurant() async {
    try {
      futureRestaurant = yelpAction.fetchRestaurant();
      futureReviews = reviewAction.fetchReviews();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView(
        children: [
          FutureBuilder<Restaurant>(
            future: futureRestaurant,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    ExpansionTile(
                      tilePadding: const EdgeInsets.only(
                        left: _paddingAmount,
                        right: _paddingAmount,
                      ),
                      childrenPadding: const EdgeInsets.only(
                        left: 15.0,
                      ),
                      collapsedIconColor: Colors.grey,
                      iconColor: Colors.grey,
                      title: Row(
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
                              right: 4.0,
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
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: _paddingAmount,
                          ),
                          child: ListTile(
                            title: Text(
                              'Hours\n'
                              '10:00am - 11:00pm',
                              style: TextStyle(
                                height: 1.5,
                                color: Colors.black,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const YelpDivider(),
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
                    const YelpDivider(),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: _paddingAmount,
                        left: _paddingAmount,
                        bottom: 20.0,
                      ),
                      child: Text(
                        'Overall Rating',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: _paddingAmount,
                        left: _paddingAmount,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            snapshot.data?.rating != null
                                ? snapshot.data!.rating.toStringAsFixed(1)
                                : '0.0',
                            style: const TextStyle(
                              fontSize: 35.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          Transform(
                            transform: Matrix4.translationValues(0.0, 2.0, 0.0),
                            child: const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const YelpDivider(),
                  ],
                );
              } else if (snapshot.hasError) {
                return const Text('Oops, it\'s Matt\'s fault');
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          FutureBuilder<GeneralReviewInfo>(
            future: futureReviews,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: _paddingAmount,
                    top: _paddingAmount,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${snapshot.data?.totalReviews ?? 0} Reviews',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      ListView.builder(
                        itemCount: snapshot.data!.individuals.length,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (_, index) {
                          return ListTile(
                            contentPadding: const EdgeInsets.only(
                              top: 12.0,
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RatingBarIndicator(
                                  rating: snapshot.data!.individuals[index].rating.toDouble(),
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 5,
                                  itemSize: 15.0,
                                  direction: Axis.horizontal,
                                  itemPadding: const EdgeInsets.only(
                                    bottom: 10.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: _paddingAmount,
                                  ),
                                  child: Text(
                                    snapshot.data!.individuals[index].reviewText,
                                    style: Theme.of(context).textTheme.bodyText1,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 12.0,
                                      bottom: 20.0,
                                  ),
                                  child: Row(
                                    children: [
                                      snapshot.data!.individuals[index].user.imageUrl != null
                                          ? Avatar(
                                              sources: [
                                                NetworkSource(snapshot.data!.individuals[index].user.imageUrl!),
                                              ],
                                              shape: AvatarShape.circle(20),
                                          )
                                          : Avatar(
                                              placeholderColors: const [Colors.orange],
                                              name: snapshot.data!.individuals[index].user.name,
                                              textStyle: const TextStyle(
                                                color: Colors.white,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              shape: AvatarShape.circle(20),
                                            ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          snapshot.data!.individuals[index].user.name,
                                          style: Theme.of(context).textTheme.bodyText1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const YelpDivider(indents: 0.0,),
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return const Text('Oops, it\'s Matt\'s fault');
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}

class YelpDivider extends StatelessWidget {
  final double? indents;

  const YelpDivider({Key? key, this.indents}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dividerTheme = Theme.of(context).dividerTheme;
    return Divider(
      height: dividerTheme.space,
      thickness: dividerTheme.thickness,
      color: dividerTheme.color,
      indent: indents ?? dividerTheme.indent,
      endIndent: indents ?? dividerTheme.endIndent,
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
