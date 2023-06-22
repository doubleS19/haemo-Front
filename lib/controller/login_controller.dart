

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

  static const storage = FlutterSecureStorage();
  dynamic userInfo ='';

  @override
  void onInit(){
    super.onInit();
    _loginService = Get.put(LoginService());
    _authManager = Get.find();

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
    autoLogin = autoLogin? false: true;
  }
}