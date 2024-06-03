import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hae_mo/service/db_service.dart';
import 'package:hae_mo/utils/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/Page/home_page.dart';
import '../model/login_model.dart';
import '../service/login_service.dart';
import 'auth_controller.dart';

class LoginController extends GetxController {
  DBService db = DBService();
  Future<bool> login(String id, String pwd) async {
    bool loginResult =
        await db.signIn(LoginRequestModel(id: id, password: pwd));
    if (loginResult) {
      PreferenceUtil.setInt("uId", id as int);
      return true;
    } else {
      return false;
    }
  }

  // Future<UserResponse?> checkUserExist(String id) async {
  //   UserResponse? user = await db.getUserById(id);
  //   return user;
  // }
}
