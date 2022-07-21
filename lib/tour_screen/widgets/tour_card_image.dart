import 'package:flutter/material.dart';
import '../../main.dart';

const double imageSize = 95;

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
    return isTestMode ? Container(
      width: imageSize,
      height: imageSize,
      color: Colors.red,
    ) : SizedBox(
      width: imageSize,
      height: imageSize,
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