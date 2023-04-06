import 'package:get/get.dart';
import 'package:hae_mo/model/shared_preference.dart';
import 'package:hae_mo/page/home_page.dart';
import "dart:developer" as dev;

import 'package:hae_mo/service/db_service.dart';

import '../model/user_model.dart';

enum RegisterState { success, fail, empty, okay }

class UserController extends GetxController {
  RegisterState _registerState = RegisterState.fail;

  RegisterState get registerState => _registerState;

  Future checkUserInfo(String nickname, String major, String gender) async {
    if (nickname.isNotEmpty && major != "학과 선택" && gender != "성별") {
      _registerState = RegisterState.okay;
      dev.log("Okay~");
    } else {
      _registerState = RegisterState.empty;
      dev.log("Empty~");
    }
    update();
  }

  Future saveInfo(String nickname, String major, String gender) async {
    if (_registerState == RegisterState.okay) {
      User user = User(nickname: nickname, major: major, gender: gender);
      _registerState = RegisterState.success;
      SharedPreference.saveUser(user);
      DBService dbService = DBService();
      dbService.saveUser(user);
    } else {
      _registerState = RegisterState.fail;
      dev.log("Fail~");
    }
    update();
  }
}
