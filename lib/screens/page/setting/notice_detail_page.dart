import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:haemo/controller/setting/notice_controller.dart';
import 'package:haemo/controller/setting/notice_visibility_controller.dart';
import 'package:haemo/model/notice_model.dart';

import '../../../common/theme.dart';
import '../../../model/notice_response_model.dart';
import '../../components/customAppBar.dart';
import 'notice_posting_page.dart';

class NoticeDetailPage extends StatelessWidget {
  NoticeDetailPage(
      {Key? key,
      required this.notice,
      required this.isAdmin,
      required this.noticeController})
      : super(key: key);

  final NoticeResponse notice;
  final bool isAdmin;
  final NoticeController noticeController;
  NoticeVisibilityController visibilityController =
      NoticeVisibilityController();

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
                              visibilityController.toggleVisibility();
                              noticeController.changeVisibility(notice);
                            },
                            icon: Obx(() => Icon(
                                  visibilityController.isVisible.value
                                      ? Icons.remove_red_eye_sharp
                                      : Icons.remove_red_eye_outlined,
                                ))))
                    : customColorAppbar(context, "공지사항"))),
        body: SingleChildScrollView(
            child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(notice.title,
                      style: CustomThemes.noticeDetailPageTitleTextStyle)),
              Row(
                children: [
                  Text("${notice.noticeType}  | ",
                      style: CustomThemes.noticeDetailPageDateTextStyle),
                  const Divider(),
                  Text(notice.date,
                      style: CustomThemes.noticeDetailPageDateTextStyle)
                ],
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(notice.content,
                      style: CustomThemes.noticeDetailPageContentTextStyle)),
              Container(
                alignment: Alignment.centerRight,
                child: Text("- 미란 -"),
              )
            ],
          ),
        )));
  }
}
