import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hae_mo/controller/login_controller.dart';
import 'package:hae_mo/controller/user_controller.dart';
import 'package:hae_mo/screens/Page/intro/register_page.dart';
import 'package:hae_mo/screens/page/intro/login_page.dart';
import 'package:hae_mo/utils/shared_preference.dart';
import 'package:hae_mo/screens/page/home_page.dart';
import "dart:developer" as dev;

import '../../../common/color.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key, required this.title});

  final String title;

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  final Duration duration = const Duration(milliseconds: 500);
  LoginController loginController = Get.put(LoginController());
  bool selected = false;
  int? id;

  @override
  void initState() {
    super.initState();
    AppTheme.getThemeType();
    id = PreferenceUtil.getInt("uId");
    changePage(id);
  }

  void changePage(int? id) {
    Timer(const Duration(milliseconds: 2000), () {
      if (id != null && id != 0) {
        loginController.checkUserExist(PreferenceUtil.getInt("studentId"));
      } else {
        Get.to(const LoginPage());
      }
    });
    Future.delayed(duration, () {
      setState(() {
        selected = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      AnimatedOpacity(
          opacity: selected ? 1.0 : 0.0,
          duration: duration,
          child: Image.asset("assets/icons/wont_icon.png",
              color: AppTheme.mainColor)),
      Image.asset("assets/icons/wont.png", color: AppTheme.mainColor)
    ])));
  }
}
