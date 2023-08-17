import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hae_mo/controller/setting_alarm_controller.dart';
import 'package:hae_mo/screens/page/setting/settings_page.dart';

import '../../../common/color.dart';
import '../../../common/theme.dart';
import '../../components/customAppBar.dart';

class SettingAlarmPage extends StatefulWidget {
  const SettingAlarmPage({Key? key}) : super(key: key);

  @override
  State<SettingAlarmPage> createState() => _SettingAlarmPageState();
}

List<String> alarmList = ['게시물', '댓글', '채팅'];

class _SettingAlarmPageState extends State<SettingAlarmPage> {
  SettingAlarmController settingAlarmController = SettingAlarmController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Builder(
                builder: (context) => customColorAppbar(context, "알림 설정"))),
        body: Container(
            decoration: BoxDecoration(color: Color(0XFFF4F4F4)),
            child: Column(
              children: [
                switchMenuItem(context, "푸시 알림 받기",-1, {}),
                menuTitle(context, "알람"),
                for (var i =0;i<3;i++ )
                  switchMenuItem(context, alarmList[i], i, {})
              ],
            )));
  }

  Widget switchMenuItem(BuildContext context, String text, int index, void onClick) {
    return Container(
        //color: Color(0XFFF4F4F4),
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
          Text(index<0?"푸시 알림 받기": "${alarmList[index!]} 알림", style: CustomThemes.settingPageMenuListTextStyle),
          CupertinoSwitch(
            value: settingAlarmController.isCheckedList[index+1],
            activeColor: AppTheme.mainColor,
            onChanged: (bool? value) {
              setState(() {
                settingAlarmController.isCheckedList[index+1] = value ?? false;
                onClick;
              });
            },
          )
        ]));
  }
}

