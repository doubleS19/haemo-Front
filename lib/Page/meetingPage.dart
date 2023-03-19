import 'package:flutter/material.dart';

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
      home: const MeetingPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MeetingPage extends StatefulWidget {
  const MeetingPage({super.key, required this.title});

  final String title;

  @override
  State<MeetingPage> createState() => _HomePageState();
}

class _HomePageState extends State<MeetingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          color: Colors.white,
          child: Text("모임 페이지")),
    );
  }
}
