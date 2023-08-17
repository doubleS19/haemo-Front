import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hae_mo/screens/page/setting/settings_page.dart';

import '../../../common/color.dart';
import '../../../common/theme.dart';
import '../../../controller/setting_screen_theme_controller.dart';
import '../../components/customAppBar.dart';

/*Map<ThemeType, String> colorTheme = {
  ThemeType.Blue: '블루', ThemeType.Beige:'베이지', ThemeType.Pink:'핑크', ThemeType.LightGreen:'연두'
};*/
List<String> colorThemeList = ['블루','베이지','핑크','연두'];

class SettingScreenThemePage extends StatefulWidget {
  const SettingScreenThemePage({Key? key}) : super(key: key);

  @override
  State<SettingScreenThemePage> createState() => _SettingScreenThemePageState();
}

class _SettingScreenThemePageState extends State<SettingScreenThemePage> {
  SettingScreenThemeController settingScreenThemeController = SettingScreenThemeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Builder(
              builder: (context) => customColorAppbar(context, "화면 설정"))),
      body: Column(
        children: [menuTitle(context, "컬러 모드"),
          for(var i = 0;i<4;i++)
            switchMenuItem(context, i)

        ],
      ),
    );
  }
  Widget switchMenuItem(BuildContext context, int index) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.of(context).size.height / 18,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: AppTheme.buttonColor,
            border: Border(
                bottom: BorderSide(
                    color: AppTheme.settingPageDividerColor, width: 3.0))),
        child:
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(colorThemeList[index], style: CustomThemes.settingPageMenuListTextStyle),
          CupertinoSwitch(
            value: settingScreenThemeController.isCheckedList[index],
            activeColor: AppTheme.mainColor,
            onChanged: (bool? value) {
              setState(() {
                settingScreenThemeController.isCheckedList[index] = value ?? false;
              });
            },
          )
        ]));
  }

}

