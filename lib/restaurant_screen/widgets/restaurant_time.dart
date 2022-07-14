import 'package:flutter/material.dart';
import 'package:yelp_review/services/restaurant_data.dart';

class RestaurantTime extends StatelessWidget {
  RestaurantTime(
      this.open, {
        Key? key,
      }) : super(key: key);

  final List<DailyHours> open;
  final List<String> dayOfTheWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
            'Hours',
            style: TextStyle(
              height: 2.0,
              color: Colors.black,
              fontSize: 15.0,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.normal,
            ),
        ),
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: open.map((time) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    dayOfTheWeek[time.day],
                    key: Key(dayOfTheWeek[time.day]),
                    style: const TextStyle(
                      height: 1.5,
                      color: Colors.black,
                      fontSize: 15.0,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 15.0,
                  ),
                  child: Text(
                    processingTime(time),
                    style: const TextStyle(
                      height: 1.5,
                      color: Colors.black,
                      fontSize: 15.0,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            )).toList(),
        ),
      ]
    );
  }
}

String processingTime(DailyHours dayInfo) {
  return '${dayInfo.startTime.toFancyTime()} - ${dayInfo.endTime.toFancyTime()}';
}

extension TimeFormatting on String {
  String toFancyTime() {
    String startTime = (int.parse(this) % 1200).toString();
    switch (startTime.length) {
      case 1:
        startTime = '120$startTime';
        break;
      case 2:
        startTime = '12$startTime';
        break;
      case 3:
        startTime = '0$startTime';
        break;
      case 4:
        break;
      default:
        startTime = '';
    }

    var timeWithColon =
        '${startTime.substring(0, 2)}:${startTime.substring(2, 4)}';
    if (int.parse(this) > 1200) {
      timeWithColon += ' PM';
    }
    else {
      timeWithColon += ' AM';
    }
    return timeWithColon;
  }
}
