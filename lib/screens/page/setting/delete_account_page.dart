import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hae_mo/common/theme.dart';
import 'package:hae_mo/screens/components/customButton.dart';
import 'package:hae_mo/screens/page/setting/settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/color.dart';
import '../../../utils/shared_preference.dart';
import '../../components/customAppBar.dart';

List<String> deleteAccountAlarm = [
  "지금 탈퇴하시면 서비스 악용 방지를 위해 재가입이 3일간 제한됩니다.",
  "프로필, 작성글 등 모든 개인 정보가 삭제됩니다."
];

class DeleteAccountPage extends StatelessWidget {
  const DeleteAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool? _isChecked = false;

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Builder(
                builder: (context) =>
                    customColorAppbar(context, menuItemList[0][1]))),
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
                        _isChecked = value;
                      }),
                  Text("안내사항을 모두 확인했습니다.",
                      style: CustomThemes.deleteAccountPageContentTextStyle),
                ]),
                const SizedBox(height: 20),
              settingPageCustomButton("회원 탈퇴", (){})
              ],
            ),
          ),
        ));
  }
}
