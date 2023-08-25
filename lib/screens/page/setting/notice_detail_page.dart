import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hae_mo/model/notice_model.dart';

import '../../components/customAppBar.dart';

class NoticeDetailPage extends StatelessWidget {
  NoticeDetailPage({Key? key, required this.notice, required this.isAdmin}) : super(key: key);

  final NoticeModel notice;
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Builder(
              builder: (context) => customColorAppbar(context, "공지사항"))),
      body:Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Text("${notice.title}"),
            Row(
              children: [
                Text(notice.noticeType),
                const Divider(),
                Text(notice.date)
              ],
            ),
            Text(notice.content),
            Text("- ${notice.MD} -" ),
          ],
        ),

      )
    );
  }
}
