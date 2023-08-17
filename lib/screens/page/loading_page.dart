import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hae_mo/screens/Page/register_page.dart';
import 'package:hae_mo/utils/shared_preference.dart';
import 'package:hae_mo/screens/page/home_page.dart';
import "dart:developer" as dev;

import '../../common/color.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key, required this.title});

  final String title;

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  final Duration duration = const Duration(milliseconds: 500);
  bool selected = false;

  @override
  void initState() {
    super.initState();

    String? id = PreferenceUtil.getString("id");
    dev.log("id: ${PreferenceUtil.getString("nickname")}");
    Timer(const Duration(milliseconds: 2000), () {
      if (id != null || id?.isNotEmpty == true || id != "") {
        Get.to(const HomePage());
      } else {
        Get.to(const RegisterPage());
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
          child: Image.asset("assets/icons/wont_icon.png", color: AppTheme.mainColor)),
      Image.asset("assets/icons/wont.png", color: AppTheme.mainColor)
    ])));
  }
}
