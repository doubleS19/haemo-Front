import 'package:intl/intl.dart';



/// YYYY년 MM월 dd일 HH시
String getNow(){
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('yyyy년 MM월 dd일 HH시');
  String formattedDate = formatter.format(now);

  return formattedDate;
}