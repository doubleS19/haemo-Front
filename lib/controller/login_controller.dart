

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../Page/home_page.dart';



enum LoginState {
  initLoginSuccess, loginSuccess, loginFail
}

class LoginController extends GetxController{
  bool _autoLogin = false;
  LoginState _loginState = LoginState.loginFail;
  static const storage = FlutterSecureStorage();
  dynamic userInfo ='';


  // 비동기로 flutter secure storage 정보를 불러오는 작업
  Future getSecureStorageInfo() async{
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    userInfo = await storage.read(key: 'login');

    // user의 정보가 있다면 자동 로그인 후 홈페이지로
    if(userInfo != null) {
      Get.offAll(const HomePage());
    } else{
      print('로그인 필요');
    }
  }

  void autoLogin (){
    _autoLogin = true;

  }

}