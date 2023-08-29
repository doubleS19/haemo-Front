import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hae_mo/controller/setting/notice_controller.dart';

import '../../components/customAppBar.dart';
import '../../components/customButton.dart';
import 'contact_page.dart';

class NoticePostingPage extends StatelessWidget {
  NoticePostingPage(
      {Key? key, required this.noticeController})
      : super(key: key);

  final NoticeController noticeController;

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
            padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
/*                contactType(context, contactEmailController),
                enterEmail(context, contactEmailController),
                contactContent(context, contactEmailController),*/
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 150,
          padding: const EdgeInsets.fromLTRB(30, 40, 30, 70),
          child: settingPageCustomButton("문의하기", () {
            //contactEmailController.sendEmail();
          }),
        ),
      ),
    );
    ;
  }
}
