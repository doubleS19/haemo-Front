import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hae_mo/screens/Page/register_page.dart';
import 'package:hae_mo/model/shared_preference.dart';
import 'package:hae_mo/screens/page/home_page.dart';
import "dart:developer" as dev;

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key, required this.title});

  final String title;

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Text(
        "헤쳐모여 TUK",
        style: TextStyle(
            fontSize: 30.0,
            color: Colors.blueGrey,
            fontWeight: FontWeight.w700),
      )),
    );
  }

  @override
  void initState() {
    String? id = PreferenceUtil.getString("id");
    dev.log("id: ${PreferenceUtil.getString("nickname")}");
    Timer(const Duration(milliseconds: 1500), () {
      if (id != null || id?.isNotEmpty == true || id != "") {
        Get.to(const HomePage());
      } else {
        Get.to(const RegisterPage());
      }
    });
  }
}
