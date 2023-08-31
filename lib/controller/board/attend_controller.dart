import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hae_mo/common/color.dart';
import "dart:developer" as dev;
import 'package:hae_mo/model/acceptation_model.dart';
import 'package:hae_mo/model/acceptation_response_model.dart';
import 'package:hae_mo/model/user_response_model.dart';
import 'package:hae_mo/screens/components/customDialog.dart';
import 'package:hae_mo/utils/shared_preference.dart';
import 'package:hae_mo/screens/page/home_page.dart';
import "dart:developer" as dev;

import 'package:hae_mo/service/db_service.dart';

enum AcceptionState { join, nonParticipation, request }

class AttendController extends GetxController {
  DBService dbService = DBService();
  AcceptionState _acceptionState = AcceptionState.nonParticipation;
  late var _buttonText;
  late var _buttonColor;
  late var _buttonBorderColor;
  late var _buttonTextColor;

  AcceptionState get acceptionState => _acceptionState;
  String get buttonText => _buttonText;
  Color get buttonColor => _buttonColor;
  Color get borderColor => _buttonBorderColor;
  Color get textColor => _buttonTextColor;

  Future requestParticipation(BuildContext context, int uId, int pId) async {
    checkState(uId, pId);
    if (_acceptionState == AcceptionState.nonParticipation) {
      bool isSuccess = await dbService
          .requestJoin(Acceptation(pId: pId, uId: uId, isAccepted: false));
      if (isSuccess) {
        // ignore: use_build_context_synchronously
        showReportSuccessDialog(
            context, "참가 요청이 완료되었습니다.\n작성자의 승인 후 참가가 확정됩니다.", "확인", () {});
        _acceptionState = AcceptionState.request;
      } else {
        // ignore: use_build_context_synchronously
        showReportSuccessDialog(
            context, "참가 요청에 실패했습니다.\n잠시 후 다시 시도해 주세요.", "확인", () {});
      }
    } else if (_acceptionState == AcceptionState.request) {
      showYesOrNoDialog(context, "참가 요청을 취소하시겠습니까?", "취소", "확인", () {
        dbService.cancleJoinRequest(uId, pId);
        _acceptionState = AcceptionState.nonParticipation;
        update();
        showReportSuccessDialog(context, "취소가 완료되었습니다.", "확인", () {});
      });
    } else {
      showYesOrNoDialog(context, "참가를 취소하시겠습니까?", "취소", "확인", () {
        dbService.cancleJoinRequest(uId, pId);
        _acceptionState = AcceptionState.nonParticipation;
        update();
        showReportSuccessDialog(context, "취소가 완료되었습니다.", "확인", () {});
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
      _buttonText = "참여하기".obs;
      _buttonBorderColor = AppTheme.mainColor.obs;
      _buttonTextColor = AppTheme.mainColor.obs;
      _buttonColor = Colors.white.obs;
    }
    update();
  }
}