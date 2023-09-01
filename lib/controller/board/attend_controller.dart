import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hae_mo/common/color.dart';
import "dart:developer" as dev;
import 'package:hae_mo/model/acceptation_model.dart';
import 'package:hae_mo/model/acceptation_response_model.dart';
import 'package:hae_mo/screens/components/customDialog.dart';
import 'package:hae_mo/screens/page/board/board_detail_page.dart';

import 'package:hae_mo/service/db_service.dart';

enum AcceptionState { join, nonParticipation, request }

class AttendController extends GetxController {
  DBService dbService = DBService();
  AcceptionState _acceptionState = AcceptionState.nonParticipation;
  var _buttonText = "참여하기".obs;
  var _buttonColor = Colors.white.obs;
  var _buttonBorderColor = AppTheme.mainColor.obs;
  var _buttonTextColor = AppTheme.mainColor.obs;
  var _userListButtonColor = Color(0xffb3b3b3).obs;
  var _isAccepted = false.obs;

  AcceptionState get acceptionState => _acceptionState;
  Rx<String> get buttonText => _buttonText;
  Rx<Color> get buttonColor => _buttonColor;
  Rx<Color> get borderColor => _buttonBorderColor;
  Rx<Color> get textColor => _buttonTextColor;
  Rx<Color> get userListButtonColor => _userListButtonColor;
  Rx<bool> get isAccepted => _isAccepted;

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
    if (isExist) {
      AcceptationResponse acceptation =
          await dbService.getRequestById(uId, pId);
      if (acceptation.isAccepted == true) {
        _acceptionState = AcceptionState.join;
        _buttonText = "참여 완료".obs;
        _buttonBorderColor = Colors.white.obs;
        _buttonTextColor = Colors.white.obs;
        _buttonColor = AppTheme.mainColor.obs;
      } else {
        _acceptionState = AcceptionState.request;
        _buttonText = "참여 대기".obs;
        _buttonBorderColor = Colors.white.obs;
        _buttonTextColor = Colors.white.obs;
        _buttonColor = AppTheme.mainColor.obs;
      }
    } else {
      _acceptionState = AcceptionState.nonParticipation;
      _buttonText = "참여하기".obs;
      _buttonBorderColor = AppTheme.mainColor.obs;
      _buttonTextColor = AppTheme.mainColor.obs;
      _buttonColor = Colors.white.obs;
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
}
