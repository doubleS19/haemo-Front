import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hae_mo/controller/image_controller.dart';
import 'package:hae_mo/controller/posting_controller.dart';
import 'package:textfield_tags/textfield_tags.dart';
import '../../model/dropdown_type.dart';
import '../../model/post_type.dart';
import '../Page/home_page.dart';
import '../components/customAppBar.dart';
import '../components/customButton.dart';
import '../components/customDialog.dart';
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
  @override
  Widget build(BuildContext context) {
    /// 상태바 설정하기
/*    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white, // 회색
    ));*/

    PostController postController = Get.put(PostController(widget.postType));

    TextfieldTagsController hashTagController = TextfieldTagsController();
    PostUi postUi = PostUi.fromType(widget.postType);
    double containerHeight = (postUi.title.length == 1)
        ? MediaQuery.of(context).size.height / 16
        : MediaQuery.of(context).size.height / 8;
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: Builder(
                    builder: (context) =>
                        customPostingAppbar(context, postUi.appBarText))),
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
                  if (widget.postType == PostType.club)
                    Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: hashTagTextField(hashTagController))
                  else
                    Container(),
                  Flexible(
                    fit: FlexFit.loose,
                    child: postingPageDetailTextField(postUi.hintText,
                        postController.detailTextContext, context),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    ),
                    child: postingButton(context, () async {
                      bool isSuccess = false;
                      if (postController.checkEmpty()) {
                        showMyAlertDialog(
                            context, "경고!!!!!", "빈칸 안 채우면 못 지나감.");
                      } else {
                        postController.saveControllerData();
                        isSuccess = await postController.saveBoard();
                        if (isSuccess) {
                          /// 다이얼로그 안 됨ㅠㅠ
                          showMyAlertDialog(
                              context, "확인요망!!", "게시물이 전송되었습니다. ");
                          postController.deleteData();
                          Get.to(const HomePage());
                        } else {
                          showMyAlertDialog(context, "ㅠ_ㅠ", "게시물 전송 실패..");
                        }
                      }
                    }),
                  )
                ],
              ),
            )));
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
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [CustomImagePicker(imgType: ImageType.hotPlaceImgList)],
      );
    case PostType.club:
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Spacer(flex: 1),
          CustomImagePicker(imgType: ImageType.logo),
          const Spacer(flex: 1),
          selectDropdownButton(MediaQuery.of(context).size.width * 0.25,
              DropDownType.person, postController),
          const Spacer(flex: 3),
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
          selectDropdownButton(MediaQuery.of(context).size.width * 0.18,
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
      var selectedHour = DateTime.now().hour;

      return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        dropDownButtonWidth(
            width * 1.2,
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
                  value = value.toString().length < 2
                      ? "0$value"
                      : value.toString();
                  postController.selectedMonth.value = value;
                })),
        dropDownButtonWidth(
            width,
            CustomDropDownButton(
                list: setDayList(),
                basicType: "$selectedDay월",
                onChanged: (value) {
                  value = value.toString().length < 2
                      ? "0$value"
                      : value.toString();
                  postController.selectedDay.value = value;
                })),
        dropDownButtonWidth(
            width,
            CustomDropDownButton(
                list: setHourList(),
                basicType: "$selectedHour시",
                onChanged: (value) {
                  value = value.toString().length < 2
                      ? "0$value"
                      : value.toString();
                  postController.selectedHour.value = value;
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

List<String> setHourList() {
  List<String> dayList = [];
  for (int i = 1; i < 25; i++) {
    dayList.add("$i시");
  }
  return dayList;
}
