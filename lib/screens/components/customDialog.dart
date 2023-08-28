import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hae_mo/common/theme.dart';
import 'package:hae_mo/screens/Page/home_page.dart';

import '../../common/color.dart';
import '../Page/board/meeting_page.dart';

void showMyAlertDialog(BuildContext context, String title, String content) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: Center(child: Text(content)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('닫기'),
        ),
      ],
    ),
  );
}

void showYesOrNoDialog(BuildContext context, String content, String cancel,
    String confirm, Function onClick) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: Container(
        height: 80,
        alignment: Alignment.center,
        child: Text(content, style: CustomThemes.customDialogContentTextStyle),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      actions: <Widget>[
        Row(
          children: [
            Expanded(
                child: Container(
                    height: 35,
                    margin: EdgeInsets.fromLTRB(6, 0, 6, 6),
                    decoration: BoxDecoration(
                        color: AppTheme.settingPageDividerColor,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(cancel,
                          style:
                              CustomThemes.customDialogCancelButtonTextStyle),
                    ))),
            Expanded(
                child: Container(
              height: 35,
              margin: EdgeInsets.fromLTRB(6, 0, 6, 6),
              decoration: BoxDecoration(
                  color: AppTheme.mainColor,
                  borderRadius: BorderRadius.circular(10.0)),
              child: TextButton(
                onPressed: () => onClick,
                child: Text(confirm,
                    style: CustomThemes.customDialogConfirmButtonTextStyle),
              ),
            )),
          ],
        )
      ],
    ),
  );
}

void restartAppDialog(BuildContext context, String content, String cancel,
    String confirm, Function onClickNo) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: Container(
        height: 80,
        alignment: Alignment.center,
        child: Text(content, style: CustomThemes.customDialogContentTextStyle),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      actions: <Widget>[
        Row(
          children: [
            Expanded(
                child: Container(
                    height: 35,
                    margin: EdgeInsets.fromLTRB(6, 0, 6, 6),
                    decoration: BoxDecoration(
                        color: AppTheme.settingPageDividerColor,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: TextButton(
                      onPressed: () {
                        onClickNo();
                        print("click No");
                        Get.back();
                        Get.back();
                      },
                      child: Text(cancel,
                          style:
                              CustomThemes.customDialogCancelButtonTextStyle),
                    ))),
            Expanded(
                child: Container(
              height: 35,
              margin: EdgeInsets.fromLTRB(6, 0, 6, 6),
              decoration: BoxDecoration(
                  color: AppTheme.mainColor,
                  borderRadius: BorderRadius.circular(10.0)),
              child: TextButton(
                onPressed: () {
                  //Navigator.of(context).popUntil((route) => route.isFirst);
                  Get.to(() => HomePage());
                  print("click Yes");
                },
                child: Text(confirm,
                    style: CustomThemes.customDialogConfirmButtonTextStyle),
              ),
            )),
          ],
        )
      ],
    ),
  );
}

Future<String?> selectListDialog(
    BuildContext context, List<String> list) async {
  return await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.0)),
        title: Text('문의 유형을 선택해주세요.',
            style: CustomThemes.customSelectListDialoglTitleTextStyle),
        content: SingleChildScrollView(
          child: ListBody(
            children: list.map((item) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(item);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(item,
                      style:
                          CustomThemes.customSelectListDialoglContentTextStyle),
                ),
              );
            }).toList(),
          ),
        ),
      );
    },
  );
}

void showReportSuccessDialog(
    BuildContext context, String content, String confirm, Function onClick) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: Container(
        height: 80,
        alignment: Alignment.center,
        child: Text(content, style: CustomThemes.customDialogContentTextStyle),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      actions: <Widget>[
        Expanded(
            child: Container(
          height: 35,
          margin: EdgeInsets.fromLTRB(6, 0, 6, 6),
          decoration: BoxDecoration(
              color: AppTheme.mainColor,
              borderRadius: BorderRadius.circular(10.0)),
          child: TextButton(
            onPressed: () => onClick,
            child: Text(confirm,
                style: const TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w400)),
          ),
        )),
      ],
    ),
  );
}
