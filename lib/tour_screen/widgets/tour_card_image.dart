import 'package:flutter/material.dart';

class TourCardImage extends StatelessWidget {
  final String imageUrl;
  final int index;

  const TourCardImage({
    Key? key,
    required this.imageUrl,
    required this.index,
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}