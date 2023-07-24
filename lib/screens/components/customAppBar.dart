import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/color.dart';
import '../Page/chat_list_page.dart';

Widget customPostingAppbar(String appBarText) {
  return Builder(
      builder: (context) => AppBar(
            title: Text(appBarText,
                style: Theme.of(context).textTheme.headlineMedium),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              color: Theme.of(context).iconTheme.color,
              icon: const Icon(Icons.arrow_back),
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ));
}



PreferredSizeWidget customMainAppbar(String appBarTitle, String subTitle){
  return AppBar(
    backgroundColor: Colors.white,
    title: Container(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 0.0),
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
    actions: [
      IconButton(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 10.0, right: 10.0),
        onPressed: () {
          Get.to(() => const ChatListPage());
        },
        icon: const Icon(Icons.menu),
        color: AppTheme.mainPageHeadlineColor,
      ),
    ],
    elevation: 0.0,
    automaticallyImplyLeading: false,
  );
}