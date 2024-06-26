// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB6MW5F9bFJkIr9Iq4Ae2ZhXwMP1um26l4',
    appId: '1:536803529638:web:065218f0b88f96286bf567',
    messagingSenderId: '536803529638',
    projectId: 'haemo-c394a',
    authDomain: 'haemo-c394a.firebaseapp.com',
    databaseURL: 'https://haemo-c394a-default-rtdb.firebaseio.com',
    storageBucket: 'haemo-c394a.appspot.com',
    measurementId: 'G-Z16D3RT9JR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC5FkHJGSA_85p2Ni7tGGMxPH-sMz6pzzc',
    appId: '1:536803529638:android:5ba8d66fbbaa05606bf567',
    messagingSenderId: '536803529638',
    projectId: 'haemo-c394a',
    databaseURL: 'https://haemo-c394a-default-rtdb.firebaseio.com',
    storageBucket: 'haemo-c394a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBmbJkK7BUpkyHSfM9Cv4iyvhkYNLxfCHw',
    appId: '1:536803529638:ios:fce4a112b9dca8316bf567',
    messagingSenderId: '536803529638',
    projectId: 'haemo-c394a',
    databaseURL: 'https://haemo-c394a-default-rtdb.firebaseio.com',
    storageBucket: 'haemo-c394a.appspot.com',
    iosBundleId: 'com.example.haeMo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBmbJkK7BUpkyHSfM9Cv4iyvhkYNLxfCHw',
    appId: '1:536803529638:ios:fce4a112b9dca8316bf567',
    messagingSenderId: '536803529638',
    projectId: 'haemo-c394a',
    databaseURL: 'https://haemo-c394a-default-rtdb.firebaseio.com',
    storageBucket: 'haemo-c394a.appspot.com',
    iosBundleId: 'com.example.haeMo',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB6MW5F9bFJkIr9Iq4Ae2ZhXwMP1um26l4',
    appId: '1:536803529638:web:f81601be0d0ea1686bf567',
    messagingSenderId: '536803529638',
    projectId: 'haemo-c394a',
    authDomain: 'haemo-c394a.firebaseapp.com',
    databaseURL: 'https://haemo-c394a-default-rtdb.firebaseio.com',
    storageBucket: 'haemo-c394a.appspot.com',
    measurementId: 'G-WQNQX8J20D',
  );

}