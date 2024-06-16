import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haemo/model/user_response_model.dart';
import 'package:haemo/screens/page/intro/register_page.dart';
import 'package:haemo/service/db_service.dart';
import 'package:haemo/utils/shared_preference.dart';
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
      PreferenceUtil.setInt("studentId", int.parse(id));
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
    int uId = await db.getUserByStudentId(studentId);

    if (uId != 0) {
      PreferenceUtil.setInt("uId", uId);
      _loginState = LoginState.success.obs;
      getUserInfoById(uId);
    } else {
      _loginState = LoginState.login.obs;
      Get.offAll(() => const RegisterPage());
    }

    update();
  }

  Future getUserInfoById(int uId) async {
    UserResponse? user = await db.getUserById(uId);

    if (user != null) {
      print("응응");
      print(user.nickname.toString());
      PreferenceUtil.setString("nickname", user.nickname);
      PreferenceUtil.setUser(user);
      print(PreferenceUtil.getUser().nickname);
      _loginState = LoginState.success.obs;
      Get.offAll(() => const HomePage());
    } else {
      _loginState = LoginState.login.obs;
      Get.offAll(() => const RegisterPage());
    }

    update();
  }
}
