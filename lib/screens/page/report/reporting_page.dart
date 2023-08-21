import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hae_mo/common/color.dart';
import 'package:hae_mo/controller/image_controller.dart';
import 'package:hae_mo/controller/posting_controller.dart';
import 'package:hae_mo/model/user_response_model.dart';
import 'package:hae_mo/service/db_service.dart';
import 'package:textfield_tags/textfield_tags.dart';
import '../../../model/dropdown_type.dart';
import '../../../model/post_type.dart';
import '../../Page/home_page.dart';
import '../../components/customAppBar.dart';
import '../../components/customButton.dart';
import '../../components/customDialog.dart';
import '../../components/customDropDownButton.dart';
import '../../components/customTextField.dart';
import '../../components/imagePicker.dart';

/// imagePicker 생성하기
/// dropdownButton 값 controller에 저장하기

class ReportingPage extends StatefulWidget {
  const ReportingPage({super.key, required this.nickname});

  final String nickname;

  @override
  State<ReportingPage> createState() => _ReportingPageState();
}

class _ReportingPageState extends State<ReportingPage> {
  List<String?> reportList = [
    "신고 사유를 선택해주세요",
    "부적절한 말(욕설/혐오/음란)",
    "허위 사실 유포",
    "채팅장 도배 및 광고",
    "기타"
  ];
  var selectedValue = "신고 사유를 선택해주세요";

  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    DBService db = DBService();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Builder(
                builder: (context) => customColorAppbar(context, "신고하기"))),
        body: FutureBuilder(
            future: db.getUserByNickname(widget.nickname),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Center(child: Text("${snapshot.error}"));
              } else if (snapshot.hasData) {
                final UserResponse user = snapshot.data!;
                return Container(
                    margin: const EdgeInsets.fromLTRB(40.0, 50.0, 40.0, 0.0),
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.nickname,
                          style: TextStyle(
                              color: AppTheme.mainColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 28.0),
                        ),
                        Text("님을 신고하시겠습니까?",
                            style: TextStyle(
                                color: AppTheme.reportingPageTextColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 22.0)),
                        const SizedBox(height: 30.0),
                        Container(
                            height: 35,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: AppTheme
                                        .postingPageDetailTextFieldColor),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15.0))),
                            child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                  value: selectedValue,
                                  menuMaxHeight: 260,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: reportList.map((value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                          overflow: TextOverflow.ellipsis),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue = value as String;
                                      //widget.postController
                                    });
                                  },
                                )))),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Container(
                            padding: const EdgeInsets.all(30),
                            height: 300,
                            alignment: Alignment.topLeft,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppTheme.postingPageDetailTextFieldColor,
                            ),
                            child: TextFormField(
                              cursorColor: AppTheme.mainPageTextColor,
                              minLines: 6,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              controller: textEditingController,
                              decoration: InputDecoration(
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  border: InputBorder.none,
                                  hintText: "신고 사유를 자세히 작성해 주세요.",
                                  hintStyle: TextStyle(
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.fontSize,
                                      fontFamily: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.fontFamily,
                                      color: AppTheme
                                          .postingPageDetailHintTextColor)),
                            )),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Container(
                            height: 42.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20.0)),
                                color: AppTheme.mainColor),
                            child: RawMaterialButton(
                                onPressed: (() {}),
                                child: const Text(
                                  "신고하기",
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                )))
                      ],
                    ));
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
