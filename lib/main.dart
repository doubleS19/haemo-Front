import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart'
    show GetMaterialApp;
import 'package:hae_mo/screens/Page/loading_page.dart';
import 'package:get/get.dart';
import 'package:hae_mo/screens/page/setting/delete_account_page.dart';

import 'common/theme.dart';
import 'utils/shared_preference.dart';
import 'networks/http_override.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  HttpOverrides.global = NoCheckCertificateHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();
  await initializeDefault();
  await GetStorage.init();

  await PreferenceUtil.init();
  runApp(const MyApp());
}

Future<void> initializeDefault() async {
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

List<List<String>> menuItemRoutes = [
  ['', '/delete-account'],
  ['/notification-settings', '/screen-settings'],
  ['/app-version', '/contact-us', '/notice'],
  ['/hemo-user-guide', '/we-made-hemo'],
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return GetMaterialApp(
      title: '헤쳐모여 TUK',
      theme: CustomThemes.mainTheme,
      home: const LoadingPage(title: 'TUK'),
      getPages: [
        GetPage(name: '/delete-account', page: () => DeleteAccountPage()),
        GetPage(name: '/notification-settings', page: () => DeleteAccountPage()),
      ],
    );
  }
}
//CustomThemes.mainTheme