import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart'
    show GetMaterialApp;
import 'package:hae_mo/Page/loading_page.dart';
import 'package:get/get.dart';
//import 'package:firebase_core/firebase_core.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return GetMaterialApp(
      title: '헤쳐모여 TUK',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoadingPage(title: '헤쳐모여 TUK'),
    );
  }
}
