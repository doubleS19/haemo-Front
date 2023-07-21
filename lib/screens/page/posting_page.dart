import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hae_mo/controller/image_controller.dart';
import 'package:hae_mo/controller/posting_controller.dart';
import '../../model/dropdown_type.dart';
import '../../model/post_type.dart';
import '../components/customAppBar.dart';
import '../components/customButton.dart';
import '../components/customDropDownButton.dart';
import '../components/customTextField.dart';
import '../components/imagePicker.dart';

/// imagePicker 생성하기
/// dropdownButton 값 controller에 저장하기

class PostingPage extends StatefulWidget {
  const PostingPage({super.key, required this.postType});

  final PostType postType;

  @override
  State<PostingPage> createState() => _PostingPageState();
}

class _PostingPageState extends State<PostingPage> {
  //final detailTextContext = TextEditingController();
  final TextEditingController selectedValueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    PostController postController = Get.put(PostController(widget.postType));
    PostUi postUi = PostUi.fromType(widget.postType);
    double containerHeight = (postUi.title.length == 1)
        ? MediaQuery.of(context).size.height / 16
        : MediaQuery.of(context).size.height / 8;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child:
                Builder(builder: (context) => customAppbar(postUi.appBarText))),
        body: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  //color: Colors.blue,
                  height: containerHeight,
                  child: enterTitleTextField(
                      postUi, postController.textControllerList)),
              SizedBox(
                //color: Colors.yellow,
                height: MediaQuery.of(context).size.height / 6,
                child: selectDropDownButtonListType(
                    widget.postType, context, postController),
              ),
              Expanded(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: postingPageDetailTextField(postUi.hintText,
                        postController.detailTextContext, context)),
              ),
              Container(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6.0))),
                  child: postingButton(context, () {
                    /// 버튼 클릭 조건 생성하기
                    postController.saveControllerData();
                    print(
                        "print categoryController: ${postController.selectedCategory.value}");
                    print(
                        "print post Category: ${postController.post.category}");
                  }))
            ],
          ),
        ));
  }
}

/// 제목 등록 TextField
Widget enterTitleTextField(
    PostUi postUi, List<TextEditingController> textController) {
  return ListView.builder(
      itemCount: min(postUi.title.length, postUi.description.length),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 7,
              child: Text(postUi.title[index],
                  style: Theme.of(context).textTheme.headlineSmall),
            ),
            Expanded(
                child: postingPageTitleTextField(
                    postUi.description[index], textController[index], context))
          ]),
        );
      });
}

/// 중간 DropDownButton & Gallery Button
Widget selectDropDownButtonListType(
    PostType type, dynamic context, PostController postController) {
  switch (type) {
    case PostType.hotPlace:
      return const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [CustomImagePicker()],
      );
    case PostType.club:
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          changeButtonToLogo(context, ImageController()),
          const Spacer(flex: 1),
          selectDropdownButton(MediaQuery.of(context).size.width * 0.25,
              DropDownType.person, postController),
          const Spacer(flex: 1),
        ],
      );
    case PostType.meeting:
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              selectDropdownButton(MediaQuery.of(context).size.width * 0.25,
                  DropDownType.person, postController),
              const Spacer(flex: 1),
              selectDropdownButton(MediaQuery.of(context).size.width * 0.35,
                  DropDownType.category, postController),
              const Spacer(flex: 2),
            ],
          ),
          selectDropdownButton(MediaQuery.of(context).size.width * 0.25,
              DropDownType.date, postController)
        ],
      );
  }
}

Widget selectDropdownButton(
    double width, DropDownType type, PostController postController) {
  List<String> list = [];

  switch (type) {
    case DropDownType.person:
      list = headCountList;
      return dropDownButtonWidth(
          width,
          CustomDropDownButton(
              list: list,
              basicType: '0명',
              onChanged: (value) {
                String? person = value?.replaceAll(RegExp('[^0-9]'), "") ?? "0";
                postController.selectedPerson.value = int.parse(person);
              }));
    case DropDownType.category:
      list = categoryList;
      return dropDownButtonWidth(
          width,
          CustomDropDownButton(
              list: list,
              basicType: "모임 카테고리",
              onChanged: (value) {
                print("category value: $value");
                postController.selectedCategory.value = value!;
              }));
    case DropDownType.date:
      var selectedYear = DateTime.now().year;
      var selectedMonth = DateTime.now().month;
      var selectedDay = DateTime.now().day;

      return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        dropDownButtonWidth(
            width,
            CustomDropDownButton(
                list: setYearList(DateTime.now().year),
                basicType: "$selectedYear년",
                onChanged: (value) {
                  postController.selectedYear.value = value!;
                })),
        dropDownButtonWidth(
            width,
            CustomDropDownButton(
                list: setMonthList(),
                basicType: "$selectedMonth월",
                onChanged: (value) {
                  postController.selectedMonth.value = value!;
                })),
        dropDownButtonWidth(
            width,
            CustomDropDownButton(
                list: setDayList(),
                basicType: "$selectedDay월",
                onChanged: (value) {
                  postController.selectedDay.value = value!;
                }))
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
