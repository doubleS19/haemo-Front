import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hae_mo/controller/posting_controller.dart';
import '../../model/dropdown_type.dart';
import '../../model/post_type.dart';
import '../../service/date_service.dart';
import '../components/customAppBar.dart';
import '../components/customDropDownButton.dart';
import '../components/customTextField.dart';
import 'home_page.dart';

class PostingPage extends StatefulWidget {
  const PostingPage({super.key, required this.postType});

  final PostType postType;

  @override
  State<PostingPage> createState() => _PostingPageState();
}

class _PostingPageState extends State<PostingPage> {
  final List<TextEditingController> _textController = [
    TextEditingController(),
    TextEditingController()
  ];
  final detailTextContext = TextEditingController();

  final BoardRegisterController _boradRegisterController =
      Get.put(BoardRegisterController());

  @override
  Widget build(BuildContext context) {
    Post post = Post.fromType(widget.postType);

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child:
                Builder(builder: (context) => customAppbar(post.appBarText))),
        body: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Flexible(
                  flex: 1,
                  child: ListView.builder(
                      itemCount:
                          min(post.title.length, post.description.length),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 17),
                            child: Row(children: [
                              Flexible(
                                  flex: 2,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(post.title[index],
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall),
                                    ],
                                  )),
                              Flexible(
                                flex: 8,
                                child: postingPageTitleTextField(
                                    post.description[index],
                                    _textController[index],
                                    context),
                              )
                            ]));
                      })),
              selectDropDownButtonType(widget.postType),
              postingPageDetailTextField(post.hintText, detailTextContext, context)
            ],
          ),
        ));
  }
}

Widget selectDropDownButtonType(PostType type) {
  switch (type) {
    case PostType.hotPlace:
      return Container();
    case PostType.club:
      return Column(
        children: [
          Row(
            children: [
              selectDropdownButton(DropDownType.headCount),
              selectDropdownButton(DropDownType.category),
            ],
          ),
          Row(
            children: [selectDropdownButton(DropDownType.date)],
          )
        ],
      );
  }
  return Container();
}

Widget selectDropdownButton(DropDownType type) {
  List<String> list = [];

  switch (type) {
    case DropDownType.headCount:
      list = headCountList;
      return dropDownButtonWidth(
          90, CustomDropDownButton(list: list, basicType: '0명'));
    case DropDownType.category:
      list = categoryList;
      return dropDownButtonWidth(
          130, CustomDropDownButton(list: list, basicType: "모임 카테고리"));
    case DropDownType.date:
      var selectedYear = DateTime.now().year;
      var selectedMonth = DateTime.now().month;
      var selectedDay = DateTime.now().day;

      return Row(children: [
        dropDownButtonWidth(
            90,
            CustomDropDownButton(
                list: setYearList(DateTime.now().year),
                basicType: "$selectedYear년")),
        dropDownButtonWidth(
            90,
            CustomDropDownButton(
                list: setMonthList(), basicType: "$selectedMonth월")),
        dropDownButtonWidth(
            90,
            CustomDropDownButton(
                list: setDayList(), basicType: "$selectedDay월"))
      ]);
  }
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
  for (int i = 1; i < 13; i++) {
    monthList.add("$i월");
  }
  return monthList;
}

List<String> setDayList() {
  List<String> dayList = [];
  for (int i = 1; i < 31; i++) {
    dayList.add("$i일");
  }
  return dayList;
}

// date 스피너
/*
Widget selectDate() {
  DateTime selectDate = DateTime.now();
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              CupertinoIcons.back,
              color: Colors.white,
              size: 26,
            ),
          ),
          IconButton(
              onPressed: () {
                selectDate = DateTime.now();
                Get.back();
              },
              icon: const Icon(
                CupertinoIcons.back,
                color: Colors.white,
                size: 26,
              )),
        ],
      ),
      const Divider(
        height: 1,
        color: Colors.blueGrey,
      ),
      const SizedBox(
        height: 10,
      ),
      SizedBox(
        height: 80,
        child: CupertinoTheme(
            data: const CupertinoThemeData(
              textTheme: CupertinoTextThemeData(
                dateTimePickerTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            child: CupertinoDatePicker(
              backgroundColor: const Color(0xffffffff),
              initialDateTime: selectDate,
              maximumYear: DateTime.now().year + 1,
              maximumDate: DateTime.now(),
              minimumYear: DateTime.now().year,
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (dateTime) {
                selectDate = dateTime;
              },
            )),
      )
    ],
  );
}
*/
