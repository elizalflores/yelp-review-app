import 'package:flutter/material.dart';
import '../../services/restaurant_data.dart';

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
            children: open.map((time) => Text(
                '${dayOfTheWeek[time.day]} ${processingTime(time)}',
                style: const TextStyle(
                  height: 1.5,
                  color: Colors.black,
                  fontSize: 15.0,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.normal,
                ),
              )).toList(),
        ),
      ]
    );
  }
}

String processingTime(DailyHours dayInfo) {

  String startTimeWithColon;
  String endTimeWithColon;

  //start parsing the start string
  if(dayInfo.startTime == '1200') {
    startTimeWithColon = '12:00 PM';
  }
  else if(dayInfo.endTime == '0000') {
    startTimeWithColon = '12:00 AM';
  }
  else {
    String startTime = (int.parse(dayInfo.startTime) % 1200).toString();
    if(startTime.length == 3) {
      startTime = '0$startTime';
    }
    startTimeWithColon =
    '${startTime.substring(0, 2)}:${startTime.substring(2, 4)}';
    if(int.parse(dayInfo.startTime) > 1200) {
      startTimeWithColon += ' PM';
    }
    else {
      startTimeWithColon += ' AM';
    }
  }

  //start parsing the end string
  if(dayInfo.endTime == '1200') {
    endTimeWithColon = '12:00 PM';
  }
  else if(dayInfo.endTime == '0000') {
    endTimeWithColon = '12:00 AM';
  }
  else {
    String endTime = (int.parse(dayInfo.endTime) % 1200).toString();
    if(endTime.length == 3) {
      endTime = '0$endTime';
    }
    endTimeWithColon =
    '${endTime.substring(0, 2)}:${endTime.substring(2, 4)}';

    if(int.parse(dayInfo.endTime) > 1200) {
      endTimeWithColon += ' PM';
    }
    else {
      endTimeWithColon += ' AM';
    }
  }

  return '$startTimeWithColon - $endTimeWithColon';
}
