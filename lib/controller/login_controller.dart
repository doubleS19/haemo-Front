import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hae_mo/model/user_response_model.dart';
import 'package:hae_mo/screens/page/intro/register_page.dart';
import 'package:hae_mo/service/db_service.dart';
import 'package:hae_mo/utils/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/Page/home_page.dart';
import '../model/login_model.dart';
import '../service/login_service.dart';
import 'auth_controller.dart';

enum LoginState { none, fail, login, success }

class LoginController extends GetxController {
  DBService db = DBService();
  Rx<LoginState> _loginState = LoginState.none.obs;

  LoginState get loginState => _loginState.value;

  final RxBool isLogin = false.obs;

  Future<bool> login(String id, String pwd) async {
    _loginState = LoginState.none.obs;

    bool loginResult =
        await db.signIn(LoginRequestModel(id: id, password: pwd));
    if (loginResult) {
      PreferenceUtil.setInt("studentId", id as int);
      _loginState = LoginState.login.obs;
      update();
      return true;
    } else {
      _loginState = LoginState.fail.obs;
      update();
      return false;
    }
  }

  Future checkUserExist(int studentId) async {
    if (_loginState == LoginState.login) {
      UserResponse? user = await db.getUserByStudentId(studentId);

      if (user != null) {
        PreferenceUtil.setUser(user);
        _loginState = LoginState.success.obs;
        Get.offAll(() => const HomePage());
      } else {
        _loginState = LoginState.login.obs;
        Get.offAll(() => const RegisterPage());
      }
    }
    update();
  }
}
