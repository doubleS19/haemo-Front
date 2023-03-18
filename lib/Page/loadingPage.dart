import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hae_mo/Page/registerPage.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '헤쳐모여 TUK',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoadingPage(title: 'Flutter Demo Home Page'),
    );
  }
}

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
    Timer(const Duration(milliseconds: 1500), () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const RegisterPage(
                    title: '헤모',
                  )));
    });
  }
}
