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
class NoticePage extends StatelessWidget {
  NoticePage({Key? key}) : super(key: key);
  NoticeController noticeController = NoticeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Builder(
          builder: (context) => customColorAppbar(context, "공지사항"),
        ),
      ),
      body: FutureBuilder(
        future: noticeController.getNotice(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Show loading indicator while waiting
          } else if (snapshot.hasError) {
            return Center(child: Text("Error fetching notices")); // Show error message if there's an error
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
              return Center(child: Text("공지사항이 존재하지 않습니다. "));
            }
          }
        },
      ),
    );
  }
}

// ... rest of your code ...


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
