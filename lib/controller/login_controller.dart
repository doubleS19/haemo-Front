

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../Page/home_page.dart';
import '../model/login_model.dart';
import '../service/login_service.dart';
import 'auth_controller.dart';



class LoginController extends GetxController{
  late final LoginService _loginService;
  late final AuthenticationManager _authManager;
  bool autoLogin = false;

  @override
  void onInit(){
    super.onInit();
    if(autoLogin){
      checkLogin();
    }
    _loginService = Get.put(LoginService());
    _authManager = Get.find();

  }

  void checkLogin(){
    _authManager.checkLoginStatus();

    if (_authManager.isLogged.value){
      /// 정보 등록 확인 및 페이지 이동
    }
  }

  Future<void> loginUser(String id, String password) async {
    final response = await _loginService
        .fetchLogin(LoginRequestModel(id: id, password: password));

    if (response != null) {
      _authManager.login(response.token);
    } else {
      Get.defaultDialog(
          middleText: 'User not found!',
          textConfirm: 'OK',
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          });
    }
  }

  void setAutoLogin(){
    print(autoLogin.toString());
    autoLogin = autoLogin? false: true;
  }
}