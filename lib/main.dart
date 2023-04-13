import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart'
    show GetMaterialApp;
import 'package:hae_mo/Page/loading_page.dart';
import 'package:get/get.dart';
import 'package:hae_mo/controller/user_controller.dart';
import 'package:hae_mo/page/chat_room_page.dart';


import 'model/shared_preference.dart';
import 'networks/http_override.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  HttpOverrides.global = NoCheckCertificateHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();
  await initializeDefault();

  await PreferenceUtil.init();
  runApp(const MyApp());
}

Future<void> initializeDefault() async{
  if (Platform.isIOS) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCIIXMlSY4xSW_h5wefZTQmjzIJ7BJBuN0",
            appId: "1:465184171545:ios:f319ab0b4b135b652eac88",
            messagingSenderId: "465184171545",
            projectId: "haemochat-b19a3"));
  } else {
    await Firebase.initializeApp();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return GetMaterialApp(
      title: '헤쳐모여 TUK',
      theme: ThemeData(
        fontFamily: 'SCDream',
        primarySwatch: Colors.blue,
      ),
      home: const ChatRoom(),
    );
  }
}
