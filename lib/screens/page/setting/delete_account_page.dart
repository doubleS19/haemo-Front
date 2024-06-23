import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haemo/common/theme.dart';
import 'package:haemo/controller/user_controller.dart';
import 'package:haemo/screens/components/customButton.dart';
import 'package:haemo/screens/components/customDialog.dart';
import 'package:haemo/screens/page/intro/login_page.dart';
import 'package:haemo/screens/page/setting/settings_page.dart';
import '../../../common/color.dart';
import '../../../utils/shared_preference.dart';
import '../../components/customAppBar.dart';

List<String> deleteAccountAlarm = [
  "지금 탈퇴하시면 서비스 악용 방지를 위해 재가입이 3일간 제한됩니다.",
  "프로필, 작성글 등 모든 개인 정보가 삭제됩니다."
];

class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({Key? key}) : super(key: key);

  @override
  _DeleteAccountPageState createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  bool _isChecked = false;
  UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Builder(
                builder: (context) =>
                    customColorAppbar(context, menuItemList[0][1]))),
        backgroundColor: Colors.white,
        body: Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width / 1.2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(height: 50),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text("${PreferenceUtil.getString("nickname")}님",
                            style:
                                CustomThemes.deleteAccountPageTitleTextStyle)),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text("탈퇴하시기전에 확인해주세요!",
                            style:
                                CustomThemes.deleteAccountPageTitleTextStyle)),
                  ],
                ),
                Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration:
                        BoxDecoration(color: CustomThemes.alarmBoxColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var text in deleteAccountAlarm)
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              child: Text("$text",
                                  style: CustomThemes
                                      .deleteAccountPageContentTextStyle)),
                      ],
                    )),
                Row(children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: (value) {
                      setState(() {
                        _isChecked = value!;
                      });
                    },
                    checkColor: Colors.white,
                    activeColor: AppTheme.mainColor,
                  ),
                  Text("안내사항을 모두 확인했습니다.",
                      style: CustomThemes.deleteAccountPageContentTextStyle),
                ]),
                const SizedBox(height: 20),
                settingPageCustomButton("회원 탈퇴", () {
                  if (_isChecked == false) {
                    showMyAlertDialog(context, "안내사항을 확인해주세요.", "확인", null);
                  } else {
                    showYesOrNoDialog(context, "계정을 삭제하시겠습니까?", "취소", "확인", () {
                      userController.deleteUser();
                    });
                  }
                })
              ],
            ),
          ),
        ));
  }
}
