import 'package:flutter/material.dart';

import '../../service/date_service.dart';

final headCountList = ["0명", "1명", "2명", "3명", "4명", "5명 이상"];
final categoryList = ["술", "미팅", "밥"];

class CustomDropDownButton extends StatefulWidget {
  const CustomDropDownButton(
      {Key? key, required this.list, required this.basicType})
      : super(key: key);

  final List<dynamic> list;
  final String basicType;

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> list = widget.list;
    String type = widget.basicType;
    String? selectedValue = list[0];

    return DropdownButtonFormField(
      value: selectedValue,
      items: list.map((value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedValue = value as String?;
        });
      },
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        filled: true,
        //fillColor: Colors.blueAccent,
      ),
    );
  }
}

Widget selectDropdownButton(String type) {
  List<String> list = [];

  switch (type) {
    case 'headCount':
      list = headCountList;
      return CustomDropDownButton(list: list, basicType: '');
    case 'category':
      list = categoryList;
      return CustomDropDownButton(list: list, basicType: "모임 카테고리");
    case 'date':
      var selectedYear = getYear();
      var selectedMonth = getMonth();
      var selectedDay = getDay();

      return Row(children: [
        CustomDropDownButton(
            list: setYearList(int.parse(selectedYear)),
            basicType: "$selectedYear년"),
        CustomDropDownButton(
            list: setMonthList(), basicType: "$selectedMonth월"),
        CustomDropDownButton(list: setDayList(), basicType: "$selectedDay월")
      ]);
  }

  return Container();
}

List<String> setYearList(int year) {
  List<String> yearList = [];
  for (int i = year; i < year + 3; i++) {
    yearList.add("$i년");
  }
  return yearList;
}

List<String> setMonthList() {
  List<String> monthList = [];
  for (int i = 0; i < 13; i++) {
    monthList.add("$i월");
  }
  return monthList;
}

List<String> setDayList() {
  List<String> dayList = [];
  for (int i = 0; i < 31; i++) {
    dayList.add("$i일");
  }
  return dayList;
}
