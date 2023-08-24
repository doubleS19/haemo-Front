import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hae_mo/controller/setting/contact_email_controller.dart';

import '../../../common/theme.dart';
import '../../components/customAppBar.dart';
import '../../components/customButton.dart';
import '../../components/customDialog.dart';
import '../../components/customTextField.dart';

List<String> contactTypeList= [
  "이용 문의",
  "버그 신고",
  "기능 추가 요청",
  "기타 문의"

];

class ContactPage extends StatelessWidget {
  ContactPage({Key? key}) : super(key: key);
  ContactEmailController contactEmailController = ContactEmailController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Builder(
          builder: (context) => customColorAppbar(context, "문의하기"),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            contactType(context, contactEmailController),
            enterEmail(context, contactEmailController),
            contactContent(context, contactEmailController),
            settingPageCustomButton("문의하기", (){}),
            const SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}

Widget contactType(BuildContext context, ContactEmailController contactEmailController){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("문의 유형",
          style: CustomThemes.customSelectListDialoglContentTextStyle),
      Obx(() {
        return TextField(
          readOnly: true, // 값을 변경하지 못하게 설정
          decoration: InputDecoration(
            hintText: "카테고리 선택",
            hintStyle: Theme.of(context).textTheme.bodySmall,
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            suffixIcon: IconButton(
              onPressed: () async {
                String? result =
                await selectListDialog(context, contactTypeList);
                if (result != null) {
                  contactEmailController.contactType.value = result;
                }
              },
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
            ),
          ),
          controller: TextEditingController(
            text: contactEmailController.contactType.value,
          ),
        );
      }),
    ],
  );
}

Widget enterEmail(BuildContext context, ContactEmailController contactEmailController){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("답변받을 이메일",
          style: CustomThemes.customSelectListDialoglContentTextStyle),
      SizedBox(
        child: postingPageTitleTextField("what'sOnTUK@example.com", contactEmailController.emailTextEditingController, context),
      ),
    ],
  );
}

Widget contactContent(BuildContext context, ContactEmailController contactEmailController){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("문의 내용",
          style: CustomThemes.customSelectListDialoglContentTextStyle),
      Container(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        height: MediaQuery.of(context).size.height/3,
        child: postingPageDetailTextField("내용을 입력하세요.", contactEmailController.emailTextEditingController, context),
      ),
    ],
  );
}