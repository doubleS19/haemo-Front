import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haemo/common/color.dart';
import "dart:developer" as dev;
import 'package:haemo/model/acceptation_model.dart';
import 'package:haemo/model/acceptation_response_model.dart';
import 'package:haemo/screens/components/customDialog.dart';

import 'package:haemo/service/db_service.dart';

enum AcceptionState { join, nonParticipation, request }

class AttendController extends GetxController {
  DBService dbService = DBService();
  AcceptionState _acceptionState = AcceptionState.nonParticipation;
  var _userListButtonColor = Color(0xffb3b3b3).obs;
  var _isAccepted = false.obs;

  Rx<Color> buttonColor = Colors.white.obs;
  Rx<Color> buttonTextColor = AppTheme.mainColor.obs;
  Rx<Color> borderColor = AppTheme.mainColor.obs;
  Rx<String> buttonText = "명단 확인".obs;

  RxList<AcceptationResponse>? _attendList = <AcceptationResponse>[].obs;

  AcceptionState get acceptionState => _acceptionState;
  Rx<Color> get userListButtonColor => _userListButtonColor;
  Rx<bool> get isAccepted => _isAccepted;
  RxList<AcceptationResponse> get acceptList =>
      _attendList == null ? <AcceptationResponse>[].obs : _attendList!;
  RxList<int> attendeesCount = <int>[].obs;

  Future requestParticipation(BuildContext context, int uId, int pId) async {
    checkState(uId, pId);
    if (_acceptionState == AcceptionState.nonParticipation) {
      bool isSuccess = await dbService
          .requestJoin(Acceptation(pId: pId, uId: uId, isAccepted: false));
      if (isSuccess) {
        // ignore: use_build_context_synchronously
        showReportSuccessDialog(
            context, "참가 요청이 완료되었습니다.\n작성자의 승인 후 참가가 확정됩니다.", "확인", () {
          Get.back();
        });
        _acceptionState = AcceptionState.request;
      } else {
        // ignore: use_build_context_synchronously
        showReportSuccessDialog(
            context, "참가 요청에 실패했습니다.\n잠시 후 다시 시도해 주세요.", "확인", () {
          Get.back();
        });
      }
    } else if (_acceptionState == AcceptionState.request) {
      showYesOrNoDialog(context, "참가 요청을 취소하시겠습니까?", "취소", "확인", () {
        dbService.cancleJoinRequest(uId, pId);
        _acceptionState = AcceptionState.nonParticipation;
        update();
        showReportSuccessDialog(context, "취소가 완료되었습니다.", "확인", () {
          Get.back();
        });
      });
    } else {
      showYesOrNoDialog(context, "참가를 취소하시겠습니까?", "취소", "확인", () {
        dbService.cancleJoinRequest(uId, pId);
        _acceptionState = AcceptionState.nonParticipation;
        update();
        showReportSuccessDialog(context, "취소가 완료되었습니다.", "확인", () {
          Get.back();
        });
      });
    }
    dev.log("승인 상태는용 ~~ ${_acceptionState.toString()}");
    update();
  }

  Future checkState(int uId, int pId) async {
    bool isExist = await dbService.checkRequestExist(uId, pId);
    dev.log("참가 요청이 존재하는가? $isExist");
    if (isExist) {
      AcceptationResponse acceptation =
          await dbService.getRequestById(uId, pId);
      if (acceptation.isAccepted == true) {
        _acceptionState = AcceptionState.join;
        buttonText.value = "참여 완료";
        borderColor.value = Colors.white;
        buttonTextColor.value = Colors.white;
        buttonColor.value = AppTheme.mainColor;
      } else {
        _acceptionState = AcceptionState.request;
        buttonText.value = "참여 대기";
        borderColor.value = Colors.white;
        buttonTextColor.value = Colors.white;
        buttonColor.value = AppTheme.mainColor;
      }
    } else {
      _acceptionState = AcceptionState.nonParticipation;
      buttonText.value = "참여하기";
      borderColor.value = AppTheme.mainColor;
      buttonTextColor.value = AppTheme.mainColor;
      buttonColor.value = Colors.white;
    }
    update();
  }

  Future setUserList(int uId, int pId) async {
    AcceptationResponse accept = await dbService.getRequestById(uId, pId);
    bool acceptResult = accept.isAccepted;
    if (acceptResult) {
      _userListButtonColor = Color(0xffb3b3b3).obs;
    } else {
      _userListButtonColor = AppTheme.mainColor.obs;
    }
    dbService.acceptUserToJoin(uId, pId);
    update();
  }

  // void fetchAttendUserList(int pId) async {
  //   try {
  //     final users = await dbService.getAttendUserList(pId);
  //     users.removeWhere((element) => element.isAccepted == false);
  //     _userList!.assignAll(users);
  //   } catch (error) {
  //     print(error.toString());
  //   }
  // }

  void fetchAttendList(int pId) async {
    try {
      final users = await dbService.getAttendList(pId);
      users.removeWhere((element) => element.isAccepted == false);
      _attendList!.assignAll(users);
    } catch (error) {
      print(error.toString());
    }
    update();
  }

  void fetchAttendeesCount() async {
    attendeesCount = List<int>.filled(10000, 0).obs;
    try {
      final countList = await dbService.getAttendeesCount();
      attendeesCount.assignAll(countList);
    } catch (error) {
      print(error.toString());
    }
    update();
  }
}
