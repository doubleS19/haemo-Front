import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart'
    show GetMaterialApp;
import 'package:haemo/firebase_options.dart';
import 'package:haemo/screens/Page/intro/loading_page.dart';
import 'package:get/get.dart';
import 'package:haemo/screens/page/setting/app_version_page.dart';
import 'package:haemo/screens/page/setting/contact_page.dart';
import 'package:haemo/screens/page/setting/delete_account_page.dart';
import 'package:haemo/screens/page/setting/alarm_setting_page.dart';
import 'package:haemo/screens/page/setting/notice_list_page.dart';
import 'package:haemo/screens/page/setting/screen_settings_page.dart';

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
  setFCM();
  runApp(const MyApp());
}

Future<void> backgroundHandler(RemoteMessage message) async {
  debugPrint('fcm backgroundHandler, message');

  debugPrint(message.notification?.title ?? '');
  debugPrint(message.notification?.body ?? '');
}

Future<void> setFCM() async {
  String token = await FirebaseMessaging.instance.getToken() ?? '';
  debugPrint("fcmToken : $token");

  NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    provisional: false,
    sound: true,
  );

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint('fcm getInitialMessage, message : ${message.data}');
    return;
  });

  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  FirebaseMessaging.instance.getInitialMessage().then((message) {
    debugPrint('fcm getInitialMessage, message : ${message?.data ?? ''}');
    if (message != null) {
      return;
    }
  });
}

Future<void> initializeDefault() async {
  if (Platform.isIOS) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  } else {
    await Firebase.initializeApp();
  }
}

List<List<String>> menuItemRoutes = [
  ['', '/delete-account'],
  ['/notification-settings', '/screen-settings'],
  ['/app-version', '/contact', '/notice'],
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
        GetPage(name: '/notification-settings', page: () => SettingAlarmPage()),
        GetPage(name: '/screen-settings', page: () => SettingScreenThemePage()),
        GetPage(name: '/contact', page: () => ContactPage()),
        GetPage(name: '/notice', page: () => NoticeListPage()),
        GetPage(name: '/app-version', page: () => AppVersionPage()),
      ],
    );
  }
}
//CustomThemes.mainTheme
