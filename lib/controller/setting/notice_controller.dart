import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:haemo/model/notice_response_model.dart';
import 'package:haemo/utils/shared_preference.dart';
import '../../model/notice_model.dart';
import '../../service/db_service.dart';

List<String> noticeType = ["안내", "공지", "업데이트"];

enum NoticeState { Before, Error, Empty, Success }

class NoticeController extends GetxController {
  DBService dbService = DBService();
  TextEditingController noticeTitleController = TextEditingController();
  TextEditingController noticeContentController = TextEditingController();
  TextEditingController mdController = TextEditingController();
  late RxList<NoticeResponse> noticeList = RxList<NoticeResponse>([]);
  Rx<NoticeState> noticeState = NoticeState.Before.obs;

  @override
  void onInit() {
    super.onInit();
    getNotice();
  }

  Future<void> getNotice() async {
    List<NoticeResponse> fetchedNotices = await dbService
        .getAllNotice()
        .then((value) => noticeList.value = value);

    if (fetchedNotices.isEmpty) {
      noticeState.value = NoticeState.Empty;
    } else {
      noticeState.value = NoticeState.Success;
    }

    if (PreferenceUtil.getString('role') == "USER") {
      noticeList.value =
          fetchedNotices.where((element) => element.visible == true).toList();
    }

    update();
  }

  void changeVisibility(NoticeResponse notice) async {
    try {
      print("print nId: ${notice.nId}");
      await dbService.changeNoticeVisibility(notice.nId!);
    } catch (error) {
      print("Controller Error change not Visible: $error");
    }
  }
}
