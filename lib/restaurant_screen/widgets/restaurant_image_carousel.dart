import 'package:flutter/material.dart';

class RestaurantImageCarousel extends StatelessWidget {
  final List<String>? photos;

  const RestaurantImageCarousel({Key? key, required this.photos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (photos != null && photos!.isNotEmpty) {
      return SizedBox(
        height: MediaQuery.of(context).size.width,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            PageView(
                children: photos!.map((photo) =>
                    Image.network(photo, fit: BoxFit.cover,)).toList()
            ),
          ],
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}