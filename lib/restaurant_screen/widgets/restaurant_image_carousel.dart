import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../main.dart';

const double imageSize = 95;

class RestaurantImageCarousel extends StatefulWidget {
  final List<String>? photos;

  const RestaurantImageCarousel({Key? key, required this.photos})
      : super(key: key);

  @override
  State<RestaurantImageCarousel> createState() => _RestaurantImageCarouselState();
}

class _RestaurantImageCarouselState extends State<RestaurantImageCarousel> {
  int activePage = 0;
  late List<String> photos;

  @override
  void initState() {
    super.initState();
    photos = widget.photos!;
  }

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(
      imagesLength,
          (index) {
        return Container(
          margin: const EdgeInsets.all(3),
          width: 7,
          height: 7,
          decoration: BoxDecoration(
              color: currentIndex == index ? Colors.black : Colors.black26,
              shape: BoxShape.circle),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isTestMode ? Container(
          width: imageSize,
          height: imageSize,
          color: Colors.red,
        ) :
        CarouselSlider(
          options: CarouselOptions(
            height: MediaQuery.of(context).size.width * 0.7,
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
            onPageChanged: (position, _) {
              setState(
                    () {
                  activePage = position;
                },
              );
            },
          ),
          items: photos.map<Widget>(
                (picture) {
              return Builder(
                builder: (BuildContext context) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * 0.7,
                    child: Image.network(
                      picture,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              );
            },
          ).toList(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: indicators(photos.length, activePage),
          ),
        ),
      ],
    );
  }
}
