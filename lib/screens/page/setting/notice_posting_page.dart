import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:haemo/controller/setting/notice_posting_controller.dart';

import '../../../common/theme.dart';
import '../../components/customAppBar.dart';
import '../../components/customButton.dart';
import '../../components/customDialog.dart';
import '../../components/customTextField.dart';

class NoticePostingPage extends StatelessWidget {
  NoticePostingPage({Key? key}) : super(key: key);

  NoticePostingController noticePostingController = NoticePostingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        //resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child:
              Builder(builder: (context) => customColorAppbar(context, "공지사항")),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                noticeType(context, noticePostingController),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("공지 제목",
                        style: CustomThemes
                            .customSelectListDialoglContentTextStyle),
                    SizedBox(
                      child: postingPageTitleTextField(
                          "",
                          noticePostingController
                              .noticeTitleTextEditingController,
                          context),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("공지 내용",
                        style: CustomThemes
                            .customSelectListDialoglContentTextStyle),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      height: MediaQuery.of(context).size.height / 2.5,
                      child: postingPageDetailTextField(
                          "내용을 입력하세요.",
                          noticePostingController
                              .noticeContentTextEditingController,
                          context),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 150,
          padding: const EdgeInsets.fromLTRB(30, 40, 30, 70),
          child: settingPageCustomButton("공지 등록", () async {
            await noticePostingController.postNotice().then((value) {
              if (value) {
                showMyAlertDialog(context, "알림", "공지사항이 등록되었습니다", () {
                  Get.back();
                  print("이게 클릭이 되는건가?");
                  Get.back();
                });
              } else {
                showMyAlertDialog(
                    context, "알림", "공지사항 등록에 실패했습니다. 다시 시도해주세요", () {});
              }
            });
          }),
        ),
      ),
    );
  }
}

Widget noticeType(
    BuildContext context, NoticePostingController noticePostingController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("문의 유형",
          style: CustomThemes.customSelectListDialoglContentTextStyle),
      Obx(() {
        return iconTextField(context, "카테고리 선택", () async {
          String? result = await selectListDialog(
              context, noticePostingController.noticeTypeList);
          if (result != null) {
            noticePostingController.noticeType.value = result;
          }
        }, noticePostingController.noticeType.value);
      }),
    ],
  );
}
