import 'dart:core';
import 'package:intl/intl.dart';

// 채팅용
String changeDatetimeToString(DateTime datetime) {
  var timeToString = DateFormat("a K:a")
      .format(datetime)
      .replaceAll("AM", "오전")
      .replaceAll("PM", "오후");
  return timeToString;
}

String changeIntToString(int timestamp) {
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  var format = DateFormat('HH시 mm분');
  return format.format(date);
}
