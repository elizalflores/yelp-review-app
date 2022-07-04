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
            Align(
              alignment: const Alignment(-1,0),
              child: Icon(
                Icons.keyboard_arrow_left,
                color: Colors.white.withOpacity(0.75),
              ),
            ),
            Align(
              alignment: const Alignment(1,0),
              child: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.white.withOpacity(0.75),
              ),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}