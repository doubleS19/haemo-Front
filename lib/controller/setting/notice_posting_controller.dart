import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../model/notice_model.dart';
import '../../service/date_service.dart';
import '../../service/db_service.dart';

class NoticePostingController extends GetxController {
  DBService dbService = DBService();
  List<String> noticeTypeList = ["공지", "업데이트", "안내"];
  TextEditingController noticeTitleTextEditingController =
      TextEditingController();
  TextEditingController noticeContentTextEditingController =
      TextEditingController();

  Rx<String> noticeType = "".obs;

  Future<bool> postNotice() async {
    bool isSuccess = false;
    try {
      isSuccess = await dbService.saveNotice(Notice(
          title: noticeTitleTextEditingController.text,
          content: noticeContentTextEditingController.text,
          MD: "MD",
          date: getNow(),
          noticeType: noticeType.value,
          visible: true));
    } catch (error) {
      print("Controller Error sending notice: $error");
    }
    return isSuccess;
  }
}
