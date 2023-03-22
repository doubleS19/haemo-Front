import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'my_page.dart';

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
      home: const ClubPage(),
    );
  }
}

class ClubPage extends StatefulWidget {
  const ClubPage({super.key});

  @override
  State<ClubPage> createState() => _ClubPageState();
}

class _ClubPageState extends State<ClubPage> {
  final List<String> exIndex = <String>[
    "23",
    "123",
    "53",
    "ccgc",
    "3",
    "cdafcc",
    "ccafc",
    "aads",
    "ava",
    "adsfqr",
    "kukd",
    "cvwe"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 10.0, left: 10.0, right: 20.0),
            color: Colors.white,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                "24시간 내에 마감되는 모임이에요!",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
              ),
              Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0)),
                  elevation: 2.0,
                  child: SizedBox(
                      width: 160.0,
                      height: 80.0,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white),
                          onPressed: () {
                            Get.to(const MyPage());
                          },
                          child: Center(
                              child: Row(
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(right: 10.0),
                                  child: const Icon(
                                    Icons.local_drink,
                                    color: Color.fromARGB(255, 137, 188, 212),
                                    size: 14.0,
                                  )),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    "오늘 8시 49에서",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15.0,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    "정왕 멋쟁이",
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              )
                            ],
                          ))))),
              const Divider(
                thickness: 2.0,
              ),
              Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(5.0),
                    itemCount: exIndex.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(children: [
                        SizedBox(
                            height: 30.0,
                            width: double.infinity,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                exIndex[index],
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            )),
                        const Divider(thickness: 1.0, color: Colors.grey)
                      ]);
                    }),
              )
            ])));
  }
}
