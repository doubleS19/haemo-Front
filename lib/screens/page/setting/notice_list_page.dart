import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hae_mo/controller/setting/notice_controller.dart';
import '../../../common/color.dart';
import '../../../common/theme.dart';
import '../../../model/notice_model.dart';
import '../../components/customAppBar.dart';
import '../../components/customIndicator.dart';
import 'notice_detail_page.dart';
import 'notice_posting_page.dart';

class NoticePage extends StatelessWidget {
  NoticePage({Key? key}) : super(key: key);
  NoticeController noticeController = NoticeController();
  bool isAdmin = true;

  @override
  Widget build(BuildContext context) {
    noticeController.getNotice();

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Builder(
              builder: (context) => isAdmin
                  ? noticePageAdminAppbar(
                      context,
                      "공지사항",
                      IconButton(
                          onPressed: () async {
                            await Get.to(() => NoticePostingPage());
                          },
                          icon: const Icon(Icons.create_outlined)))
                  : customColorAppbar(context, "공지사항"))),
      body: Obx(() {
        noticeController.getNotice();

        print("Notice State: ${noticeController.noticeState.value}");

        if (noticeController.noticeState.value == NoticeState.Empty) {
          return const Center(child: Text("공지사항이 존재하지 않습니다. "));
        } else if (noticeController.noticeState.value == NoticeState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (noticeController.noticeState.value == NoticeState.Error) {
          return const Center(child: Text("공지사항을 불러오는데 실패했습니다. 다시 시도해주세요."));
        }

        return ListView.builder(
          itemCount: noticeController.noticeList!.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              alignment: Alignment.center,
              child: noticeCard(context,
                  noticeController.noticeList!.value[index], noticeController),
            );
          },
        );
      }),
    );
  }
}

Widget noticeCard(
    BuildContext context, Notice notice, NoticeController noticeController) {
  return GestureDetector(
      onTap: () {
        Get.to(() => NoticeDetailPage(
            notice: notice, isAdmin: true, noticeController: noticeController));
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.postingPageHeadlineColor,
        ),
        height: /*MediaQuery.of(context).size.height*/ 80,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
