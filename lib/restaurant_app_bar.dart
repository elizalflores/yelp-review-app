import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RestaurantAppBar extends StatelessWidget {
  final String title;
  final double? elevation;

  const RestaurantAppBar({Key? key, required this.title, this.elevation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).primaryColor,
        statusBarIconBrightness: Theme.of(context).brightness,
      ),
      title: Text(
        title.isNotEmpty ? title : 'This is a Restaurant Name',
        style: Theme.of(context).textTheme.headline1,
        overflow: TextOverflow.ellipsis,
      ),
      centerTitle: true,
      backgroundColor: Theme.of(context).primaryColor,
      elevation: elevation ?? 0,
    );
  }
}
