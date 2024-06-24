import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:haemo/common/theme.dart';
import 'package:haemo/common/user_image.dart';
import 'package:haemo/controller/board/attend_controller.dart';
import 'package:haemo/model/user_response_model.dart';
import 'package:haemo/screens/Page/home_page.dart';
import 'package:haemo/service/db_service.dart';

import '../../common/color.dart';

void showMyAlertDialog(
    BuildContext context, String title, String content, Function? onClick) {
  Function? onPressed = (onClick != null)
      ? onClick
      : () {
          Navigator.of(context).pop();
        };
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: Container(
        height: 100,
        child: Center(child: Text(content)),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            onPressed.call();
          },
          child: const Text('닫기'),
        ),
      ],
    ),
  );
}

void showConfirmDialog(
    BuildContext context, String content, Function? onClick) {
  Function? onPressed = (onClick != null)
      ? onClick
      : () {
          Navigator.of(context).pop();
        };
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        height: 100,
        child: Center(child: Text(content)),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: AppTheme.mainColor,
          ),
          onPressed: () {
            onPressed();
          },
          child: Text("확인",
              style: CustomThemes.customDialogConfirmButtonTextStyle),
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
                onPressed: () {
                  Navigator.of(context).pop();
                  onClick();
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
    BuildContext context, String content, String confirm, Function onPressed) {
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
            onPressed: () {
              Navigator.of(context).pop();
              onPressed();
            },
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

showAttendUserDialog(BuildContext context, List<UserResponse> user, int person,
    AttendController controller, int pId) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (context, animation, secondaryAnimation) {
      return Center(
        child: Container(
            width: 300,
            height: 350,
            color: Colors.transparent,
            child: Expanded(
              child: ListView.builder(
                  itemCount: person,
                  itemBuilder: (context, index) {
                    final attendUser = user[index];
                    return GestureDetector(
                        onTap: () {
                          controller.setUserList(attendUser.uId, pId);
                        },
                        child: Column(children: [
                          Container(
                              height: 60.0,
                              width: 250.0,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30.0)),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: SizedBox(
                                          height: 41.0,
                                          width: 41.0,
                                          child: Container(
                                            width: 41,
                                            height: 41,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.transparent,
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    userRoundImage[
                                                        attendUser.userImage]),
                                              ),
                                            ),
                                          ))),
                                  Expanded(
                                      flex: 3,
                                      child: Center(
                                        child: Text(attendUser.nickname,
                                            style: const TextStyle(
                                              fontSize: 14.0,
                                              color: AppTheme.mainTextColor,
                                              decoration: TextDecoration.none,
                                            )),
                                      )),
                                  Obx(() => Expanded(
                                      flex: 1,
                                      child: SizedBox(
                                          height: 14,
                                          width: 14.0,
                                          child: Image(
                                            image: const AssetImage(
                                              "assets/icons/accept_user_icon.png",
                                            ),
                                            color: controller
                                                .userListButtonColor.value,
                                          ))))
                                ],
                              )),
                          const SizedBox(
                            height: 20.0,
                          )
                        ]));
                  }),
            )),
      );
    },
  );
}

void replyDialog(BuildContext context, String content, String cancel,
    String confirm, Function onClick, Function onCancel) {
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
                        onCancel();
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
                  Navigator.of(context).pop();
                  onClick();
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

Future<String?> boardWriterAppBarDialog(
    BuildContext context, int pId, int type) async {
  final db = DBService();
  final list = ["임시 마감", "수정하기", "삭제하기"];
  bool isDeleted = false;
  onClick(String value) async {
    if (value == "임시 마감") {
      print("임시 마감");
    } else if (value == "수정하기") {
      print("수정하기");
    } else if (value == "삭제하기") {
      isDeleted = type == 1
          ? await db.deletePost(pId)
          : (type == 2
              ? await db.deleteClubPost(pId)
              : await db.deleteHotPlacePost(pId));
      Get.back();
    }
  }

  return await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.0)),
        content: SingleChildScrollView(
          child: ListBody(
            children: list.map((item) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(item);
                  onClick(item);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    item,
                    style: CustomThemes.customSelectListDialoglContentTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
    },
  );
}
