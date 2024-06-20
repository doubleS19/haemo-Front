import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haemo/common/color.dart';
import 'package:haemo/controller/setting/contact_email_controller.dart';
import 'package:haemo/model/user_response_model.dart';
import 'package:haemo/screens/components/customDialog.dart';
import 'package:haemo/screens/page/home_page.dart';
import 'package:haemo/service/db_service.dart';
import '../../Page/home_page.dart' as fix;
import '../../components/customAppBar.dart';
import '../../components/customButton.dart';

/// imagePicker 생성하기
/// dropdownButton 값 controller에 저장하기

class ReportingPage extends StatefulWidget {
  const ReportingPage({super.key, required this.user});
  final UserResponse user;

  @override
  State<ReportingPage> createState() => _ReportingPageState();
}

class _ReportingPageState extends State<ReportingPage> {
  ContactEmailController contactEmailController = ContactEmailController();
  List<String?> reportList = [
    "신고 사유를 선택해주세요",
    "부적절한 말(욕설/혐오/음란)",
    "허위 사실 유포",
    "채팅장 도배 및 광고",
    "기타"
  ];
  var selectedValue = "신고 사유를 선택해주세요";
  var selectedUser = null;

  @override
  void initState() {
    super.initState();
  }

  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    selectedUser = contactEmailController.reportedUser;
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: Builder(
                    builder: (context) => customColorAppbar(context, "신고하기"))),
            body: SingleChildScrollView(
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    margin: const EdgeInsets.fromLTRB(40.0, 50.0, 40.0, 0.0),
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.user.nickname,
                          style: TextStyle(
                              color: AppTheme.mainColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 28.0),
                        ),
                        const Text("님을 신고하시겠습니까?",
                            style: TextStyle(
                                color: AppTheme.reportingPageTextColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 22.0)),
                        const SizedBox(height: 30.0),
                        Container(
                            height: 40,
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
                                      contactEmailController.contactType.value =
                                          selectedValue;
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
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                  color: AppTheme.mainTextColor),
                              cursorColor: AppTheme.mainPageTextColor,
                              minLines: 12,
                              maxLines: 12,
                              maxLength: 500,
                              keyboardType: TextInputType.multiline,
                              controller: textEditingController,
                              decoration: InputDecoration(
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  border: InputBorder.none,
                                  hintText: "신고 사유를 자세히 작성해 주세요.",
                                  hintStyle: TextStyle(
                                      fontSize: 14.0,
                                      fontFamily: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.fontFamily,
                                      color: AppTheme
                                          .postingPageDetailHintTextColor)),
                              onChanged: (value) {
                                contactEmailController.contactContent.value =
                                    value;
                              },
                            )),
                        const SizedBox(
                          height: 30.0,
                        ),
                      ],
                    ))),
            bottomNavigationBar: Container(
              height: 150,
              padding: const EdgeInsets.fromLTRB(30, 40, 30, 70),
              child: reportingPageCustomBotton(
                  "신고하기", widget.user.nickname, context, () {
                contactEmailController.sendEmail(2, widget.user);
                return showReportSuccessDialog(context, "신고가 완료되었습니다.", "확인",
                    () {
                  {
                    Get.offAll(() => const HomePage());
                  }
                });
              }),
            )));
  }
}
