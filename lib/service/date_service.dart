

import 'package:intl/intl.dart';

String getYear(){
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('yyyy');
  var strYear = formatter.format(now);
  return strYear;
}

String getMonth(){
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('MM');
  var strMonth = formatter.format(now);
  return strMonth;
}

String getDay(){
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('dd');
  var strDay = formatter.format(now);
  return strDay;
}
