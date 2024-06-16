import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:haemo/controller/setting/contact_email_controller.dart';

import '../../../common/theme.dart';
import '../../components/customAppBar.dart';
import '../../components/customButton.dart';
import '../../components/customDialog.dart';
import '../../components/customTextField.dart';

List<String> contactTypeList = ["이용 문의", "버그 신고", "기능 추가 요청", "기타 문의"];

class ContactPage extends StatelessWidget {
  ContactPage({Key? key}) : super(key: key);
  ContactEmailController contactEmailController = ContactEmailController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        //resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Builder(
            builder: (context) => customColorAppbar(context, "문의하기"),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                contactType(context, contactEmailController),
                enterEmail(
                    context, contactEmailController.emailTextEditingController),
                contactContent(context,
                    contactEmailController.contentTextEditingController),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 150,
          padding: const EdgeInsets.fromLTRB(30, 40, 30, 70),
          child: settingPageCustomButton("문의하기", () {
            contactEmailController.sendEmail();
          }),
        ),
      ),
    );
  }
}

Widget contactType(
    BuildContext context, ContactEmailController contactEmailController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("문의 유형",
          style: CustomThemes.customSelectListDialoglContentTextStyle),
      Obx(() {
        return iconTextField(
          context,
          "카테고리 선택",
          () async {
            String? result = await selectListDialog(context, contactTypeList);
            if (result != null) {
              contactEmailController.contactType.value = result;
            }
          },
          contactEmailController.contactType.value,
        );
      }),
    ],
  );
}

Widget enterEmail(
    BuildContext context, TextEditingController textEditingController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("답변받을 이메일",
          style: CustomThemes.customSelectListDialoglContentTextStyle),
      SizedBox(
        child: postingPageTitleTextField(
            "what'sOnTUK@example.com", textEditingController, context),
      ),
    ],
  );
}

Widget contactContent(
    BuildContext context, TextEditingController textEditingController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("문의 내용",
          style: CustomThemes.customSelectListDialoglContentTextStyle),
      Container(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        height: MediaQuery.of(context).size.height / 2.5,
        child: postingPageDetailTextField(
            "내용을 입력하세요.", textEditingController, context),
      ),
    ],
  );
}
