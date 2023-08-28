import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hae_mo/model/notice_model.dart';

import '../../../common/theme.dart';
import '../../components/customAppBar.dart';

class NoticeDetailPage extends StatelessWidget {
  NoticeDetailPage({Key? key, required this.notice, required this.isAdmin})
      : super(key: key);

  final Notice notice;
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Builder(
                builder: (context) => customColorAppbar(context, "공지사항"))),
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
                child: Text("- ${notice.MD} -"),
              )
            ],
          ),
        )));
  }
}
