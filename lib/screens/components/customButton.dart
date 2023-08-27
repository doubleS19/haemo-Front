import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hae_mo/controller/image_controller.dart';
import 'package:hae_mo/controller/posting_controller.dart';
import 'package:hae_mo/controller/setting/contact_email_controller.dart';
import 'package:hae_mo/screens/page/home_page.dart';

import '../../common/color.dart';
import '../../common/theme.dart';

/// PostingPage 등록 버튼
Widget postingButton(BuildContext context, void Function()? onPressed) {
  return ElevatedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(backgroundColor: AppTheme.mainColor),
      child: Text("등록하기",
          style: TextStyle(
              fontFamily: Theme.of(context).textTheme.headlineSmall?.fontFamily,
              fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
              color: AppTheme.postingPageHeadlineColor)));
}

Widget settingPageCustomButton(String content, Function onClick) {
  return GestureDetector(
    onTap: () {
      onClick();
    },
    child: Container(
        height: 45,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: AppTheme.mainColor, borderRadius: BorderRadius.circular(50)),
        child: Center(
          child: Text(content,
              style: CustomThemes.deleteAccountPageButtonTextStyle),
        )),
  );
}

Widget reportingPageCustomBotton(String content) {
  ContactEmailController contactEmailController = ContactEmailController();
  return Container(
      height: 42.0,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          color: AppTheme.mainColor),
      child: RawMaterialButton(
          onPressed: (() {
            HomePage homePage = HomePage();
            contactEmailController.sendEmail();
            Get.offAll(() => homePage);
          }),
          child: const Text(
            "신고하기",
            style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          )));
}
