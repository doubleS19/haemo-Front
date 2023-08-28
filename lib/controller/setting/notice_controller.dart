import 'package:flutter/cupertino.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hae_mo/model/notice_response_model.dart';
import '../../model/notice_model.dart';
import '../../service/db_service.dart';

List<String> noticeType = ["안내", "공지", "업데이트"];

class NoticeController extends GetxController {
  DBService dbService = DBService();
  TextEditingController noticeTitleController = TextEditingController();
  TextEditingController noticeContentController = TextEditingController();
  TextEditingController mdController = TextEditingController();
  late RxList<Notice>? noticeList = RxList<Notice>([]);

  @override
  void onInit() {
    super.onInit();
    getNotice();
  }


  Future<List<Notice>> getNotice() async {
    List<Notice> fetchedNotices = [];
    try {
      fetchedNotices = await dbService.getAllNotice();
    } catch (error) {
      print("Error getting notices: $error");
    }
    return fetchedNotices;
  }

  void postNotice(Notice notice) async {
    try {
      await dbService.saveNotice(notice);
      getNotice();
    } catch (error) {
      print("Controller Error sending email: $error");
    }
  }
}



