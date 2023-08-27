import 'package:flutter/cupertino.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../model/notice_model.dart';
import '../../service/db_service.dart';

List<String> noticeType = ["안내", "공지", "업데이트"];

class NoticeController extends GetxController {
  TextEditingController noticeTitleController = TextEditingController();
  TextEditingController noticeContentController = TextEditingController();
  TextEditingController mdController = TextEditingController();
  final RxList<Notice> noticeList = [
    Notice(
        title: "title",
        content: "content",
        MD: "MD",
        date: "2023년 2월 25일",
        noticeType: "공지",
        visible: true),
    Notice(
        title: "title",
        content: "content",
        MD: "MD",
        date: "2023년 2월 25일",
        noticeType: "공지",
        visible: true),
    Notice(
        title: "title",
        content: "content",
        MD: "MD",
        date: "2023년 2월 25일",
        noticeType: "공지",
        visible: true)
  ].obs;

  void getNotice() {}

  void postNotice() async {
    try {} catch (error) {
      print("Controller Error sending email: $error");
    }
  }
}
