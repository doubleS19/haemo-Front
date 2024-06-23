import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:haemo/screens/components/customDialog.dart';
import 'package:haemo/utils/shared_preference.dart';

import '../../../common/color.dart';
import '../../../common/theme.dart';
import '../../components/customAppBar.dart';

List<String> menuTitleList = ["설정", "앱 설정", "앱 정보", "우리를 소개합니당~~^^*"];
List<List<String>> menuItemList = [
  ["로그아웃", "계정 탈퇴"],
  ["알림 설정", "화면 설정"],
  ["앱 버전", "문의하기", "공지사항"],
  ["헤모 이용가이드", "헤모는 우리가 만들었습니당~><"]
];

List<List<String>> menuItemRoutes = [
  ['', '/delete-account'],
  ['/notification-settings', '/screen-settings'],
  ['/app-version', '/contact', '/notice'],
  ['/hemo-user-guide', '/we-made-hemo'],
];

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child:
              Builder(builder: (context) => customColorAppbar(context, "설정"))),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: menuTitleList.length,
        itemBuilder: (BuildContext context, int index) {
          return menuType(context, index);
        },
      ),
    );
  }
}

Widget menuType(BuildContext context, int sectionIndex) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      menuTitle(context, menuTitleList[sectionIndex]),
      Column(
        children: menuItemList[sectionIndex]
            .asMap()
            .map((itemIndex, itemText) => MapEntry(
                  itemIndex,
                  menuItem(context, itemText, sectionIndex, itemIndex),
                ))
            .values
            .toList(),
      ),
    ],
  );
}

Widget menuTitle(BuildContext context, String text) {
  return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
      height: MediaQuery.of(context).size.height / 17,
      width: MediaQuery.of(context).size.width,
      color: AppTheme.settingPageDividerColor,
      child: Align(
          alignment: Alignment.centerLeft,
          child: Text(text, style: CustomThemes.settingPageMenuTextStyle)));
}

Widget menuItem(
    BuildContext context, String text, int sectionIndex, int itemIndex) {
  return GestureDetector(
      onTap: () {
        if (menuItemRoutes[sectionIndex][itemIndex] == '') {
          showYesOrNoDialog(context, "로그아웃 하시겠습니까?", '아니요', '예', () {
            PreferenceUtil.clear();
            Get.offAllNamed('/login');
          });
        } else {
          Get.toNamed(menuItemRoutes[sectionIndex][itemIndex]);
        }
      },
      child: Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          height: MediaQuery.of(context).size.height / 18,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: AppTheme.settingPageDividerColor, width: 3.0))),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(text, style: CustomThemes.settingPageMenuListTextStyle),
                  Icon(Icons.keyboard_arrow_right, color: AppTheme.mainColor)
                ],
              ))));
}
