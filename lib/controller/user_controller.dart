import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hae_mo/page/home_page.dart';

enum RegisterState { Success, Fail, Empty, Okay }

class UserController extends GetxController {
  RegisterState _registerState = RegisterState.Fail;

  Future<bool> CheckUserInfo(
      String nickname, String major, String gender) async {
    if (nickname != "" && major != "학과 선택") {
      _registerState = RegisterState.Okay;
      return true;
    } else {
      _registerState = RegisterState.Empty;
      return false;
    }
    update();
  }

  Future<bool> SaveInfo(String nickname, String major, String gender) async {
    if (_registerState == RegisterState.Okay) {
      _registerState = RegisterState.Success;
      Get.to(HomePage());
      return true;
    } else {
      _registerState = RegisterState.Fail;
      return false;
    }
    update();
  }
}
