import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../common/color.dart';
import '../Page/chat/chat_list_page.dart';
import 'customDialog.dart';

Widget customColorAppbar(BuildContext context, String appBarText) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white, // 회색
  ));

  return AppBar(
    title: Text(appBarText, style: Theme.of(context).textTheme.headlineMedium),
    centerTitle: true,
    leading: IconButton(
      onPressed: () {
        Get.back();
      },
      color: Theme.of(context).iconTheme.color,
      icon: const Icon(Icons.arrow_back),
    ),
    elevation: 0.0,
    backgroundColor: AppTheme.mainColor,
  );
}

PreferredSizeWidget customMainAppbar(String appBarTitle, String subTitle) {
  return AppBar(
    backgroundColor: Colors.white,
    title: Container(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 10.0),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appBarTitle,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 17.0,
              color: AppTheme.mainPageHeadlineColor,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            subTitle,
            style: TextStyle(
              color: AppTheme.mainTextColor,
              fontSize: 10.0,
            ),
          ),
        ],
      ),
    ),
    shape: Border(
      bottom: BorderSide(
        color: AppTheme.dividerColor,
        width: 0.5,
      ),
    ),
    actions: [
      IconButton(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 10.0, right: 10.0),
        onPressed: () {
          Get.to(() => const ChatListPage());
        },
        icon: const Icon(Icons.menu),
        color: AppTheme.mainColor,
      ),
    ],
    elevation: 0.0,
    automaticallyImplyLeading: false,
  );
}

AppBar backAppBar() {
  return AppBar(
    backgroundColor: Colors.white,
    leading: IconButton(
      onPressed: () {
        Get.back();
      },
      color: AppTheme.dividerColor,
      icon: const Icon(Icons.arrow_back_ios_new_sharp),
    ),
    elevation: 0.0,
    automaticallyImplyLeading: false,
    shape: Border(
      bottom: BorderSide(
        color: AppTheme.mainColor,
        width: 0.5,
      ),
    ),
  );
}


Widget 성(BuildContext context, String appBarText) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white, // 회색
  ));

  return AppBar(
    title: Text(appBarText, style: Theme.of(context).textTheme.headlineMedium),
    centerTitle: true,
    leading: IconButton(
      onPressed: () {
        restartAppDialog(context, "테마 설정을 위해 앱이 재시작됩니다.","아니요", "예", (){
          print("click Yes");
          Get.back();
          //Get.back();
        }, (){
          Navigator.of(context).popUntil((route) => route.isFirst);
          print("click Yes");
        });
      },
      color: Theme.of(context).iconTheme.color,
      icon: const Icon(Icons.arrow_back),
    ),
    elevation: 0.0,
    backgroundColor: AppTheme.mainColor,
  );
}
