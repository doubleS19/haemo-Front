import 'package:flutter/cupertino.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:haemo/model/notice_response_model.dart';
import '../../model/notice_model.dart';
import '../../service/db_service.dart';

List<String> noticeType = ["안내", "공지", "업데이트"];

enum NoticeState { Before, Error, Empty, Success }

class NoticeController extends GetxController {
  DBService dbService = DBService();
  TextEditingController noticeTitleController = TextEditingController();
  TextEditingController noticeContentController = TextEditingController();
  TextEditingController mdController = TextEditingController();
  late RxList<Notice>? noticeList = RxList<Notice>([]);
  Rx<NoticeState> noticeState = NoticeState.Before.obs;

  @override
  void onInit() {
    super.onInit();
    getNotice();
  }

  Future<void> getNotice() async {
    List<Notice> fetchedNotices = [];
    try {
      fetchedNotices = await dbService.getAllNotice();

      if (fetchedNotices.isEmpty) {
        noticeState.value = NoticeState.Empty;
      } else {
        noticeState.value = NoticeState.Success;
        noticeList?.value =
            fetchedNotices.where((e) => e.visible == true).toList();
      }
      print("print nId: ${noticeList?.value[0].nId.toString()}");
    } catch (error) {
      print("Error getting notices: $error");
      noticeState.value = NoticeState.Error;
    }
  }

  void changeVisibility(Notice notice) async {
    try {
      print("print nId: ${notice.nId}");
      await dbService.changeNoticeVisibility(notice.nId!);
    } catch (error) {
      print("Controller Error change not Visible: $error");
    }
  }
}
