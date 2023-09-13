import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hae_mo/controller/setting/contact_email_controller.dart';
import 'package:hae_mo/screens/components/customDialog.dart';
import 'package:hae_mo/screens/page/home_page.dart';

import '../../common/color.dart';
import '../../common/theme.dart';

/// PostingPage 등록 버튼
Widget postingButton(BuildContext context, void Function()? onPressed) {
  return GestureDetector(
      onTap: onPressed,
      child: Container(
          height: 45,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              color: AppTheme.mainColor,
              borderRadius: BorderRadius.circular(50)),
          child: Center(
            child: Text("등록하기",
                style: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.headlineSmall?.fontFamily,
                    fontSize:
                        Theme.of(context).textTheme.headlineSmall?.fontSize,
                    color: AppTheme.white)),
          )));
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

Widget reportingPageCustomBotton(
    String content, String nickname, BuildContext context, Function onClick) {
  ContactEmailController contactEmailController = ContactEmailController();
  return Container(
      height: 42.0,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          color: AppTheme.mainColor),
      child: RawMaterialButton(
          onPressed: (() {
            showYesOrNoDialog(
                context, "$nickname님을 신고하시겠습니까?", "취소", "확인", onClick);
          }),
          child: const Text(
            "신고하기",
            style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          )));
}
