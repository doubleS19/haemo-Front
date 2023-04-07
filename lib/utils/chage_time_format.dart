import 'dart:core';
import 'package:intl/intl.dart';



// 채팅용
String changeDatetimeToString(DateTime datetime){
  var timeToString = DateFormat("a K:a")
      .format(datetime)
      .replaceAll("AM", "오전")
      .replaceAll("PM", "오후");
  return timeToString;
}
