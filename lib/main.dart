import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart'
    show GetMaterialApp;
import 'package:hae_mo/Page/clubPage.dart';
import 'package:hae_mo/Page/loadingPage.dart';
import 'package:hae_mo/Page/myPage.dart';
import 'package:hae_mo/Page/recommendPage.dart';
import 'Page/meetingPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '헤쳐모여 TUK',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoadingPage(title: '헤쳐모여 TUK'),
    );
  }
}
