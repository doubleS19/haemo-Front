
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hae_mo/controller/setting/notice_controller.dart';
import 'package:hae_mo/model/notice_model.dart';

import '../../../common/color.dart';
import '../../../common/theme.dart';
import '../../components/customAppBar.dart';
import 'notice_detail_page.dart';

class NoticePage extends StatelessWidget {
  NoticePage({Key? key}) : super(key: key);
  NoticeController noticeController = NoticeController();

  @override
  Widget build(BuildContext context) {
    noticeController.noticeList.value = [NoticeModel(title: "title", content: "content", MD: "MD", date: "2023년 2월 25일", noticeType: "공지", visible: true)];

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Builder(
              builder: (context) => customColorAppbar(context, "공지사항"))),
      body: Container(
        decoration: BoxDecoration(
          color: AppTheme.settingPageDividerColor
        ),
        child: Obx(
                () => noticeController.noticeList.value.isNotEmpty
                ? ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: noticeController.noticeList.value.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15),
                    alignment: Alignment.center,
                    child: noticeCard(
                        context,
                        noticeController.noticeList.value[index]));
              },
            )
                : const Center(child: Text("공지사항이 존재하지 않습니다. ")))
      ),
    );
  }
}

Widget noticeCard(BuildContext context, NoticeModel notice){
  return GestureDetector(
    onTap: (){
      Get.to(()=> NoticeDetailPage(notice: notice, isAdmin: true));
    },
    child: Container(
      decoration: BoxDecoration(
        color: AppTheme.postingPageHeadlineColor,
      ),
      height: /*MediaQuery.of(context).size.height*/100,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("[${notice.noticeType}] ${notice.title}", style: CustomThemes.noticePageMenuListTextStyle),
              Text(notice.date, style: CustomThemes.noticePageDateTextStyle)
            ],
          ), 
          Icon(Icons.keyboard_arrow_right_outlined, color: AppTheme.noticePageIconColor)
        ],
      ),
    )
  );
}