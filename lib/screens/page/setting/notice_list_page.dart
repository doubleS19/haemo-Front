import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hae_mo/controller/setting/notice_controller.dart';
import 'package:hae_mo/model/notice_response_model.dart';

import '../../../common/color.dart';
import '../../../common/theme.dart';
import '../../../model/notice_model.dart';
import '../../components/customAppBar.dart';
import 'notice_detail_page.dart';
import 'notice_posting_page.dart';

class NoticePage extends StatelessWidget {
  NoticePage({Key? key}) : super(key: key);
  NoticeController noticeController = NoticeController();

  bool isAdmin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Builder(
              builder: (context) => isAdmin
                  ? noticePageAdminAppbar(
                      context,
                      "공지사항",
                      IconButton(
                          onPressed: () {
                            Get.to(() => NoticePostingPage(noticeController: noticeController));
                          },
                          icon: const Icon(Icons.create_outlined))):customColorAppbar(context, "공지사항"))),
      body: FutureBuilder(
        future: noticeController.getNotice(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Show loading indicator while waiting
          } else if (snapshot.hasError) {
            return const Center(
                child: Text(
                    "공지사항을 받아오는데 실패했습니다. 다시 시도해주세요."));
          } else {
            snapshot.data;
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    alignment: Alignment.center,
                    child: noticeCard(
                        context, snapshot.data![index], noticeController),
                  );
                },
              );
            } else {
              return const Center(child: Text("공지사항이 존재하지 않습니다. "));
            }
          }
        },
      ),
    );
  }
}


Widget noticeCard(BuildContext context, Notice notice, NoticeController noticeController) {
  return GestureDetector(
      onTap: () {
        Get.to(() => NoticeDetailPage(notice: notice, isAdmin: true, noticeController: noticeController));
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.postingPageHeadlineColor,
        ),
        height: /*MediaQuery.of(context).size.height*/ 100,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("[${notice.noticeType}] ${notice.title}",
                    style: CustomThemes.noticePageMenuListTextStyle),
                Text(notice.date, style: CustomThemes.noticePageDateTextStyle)
              ],
            ),
            Icon(Icons.keyboard_arrow_right_outlined,
                color: AppTheme.noticePageIconColor)
          ],
        ),
      ));
}
