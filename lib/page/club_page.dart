import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chat_list_page.dart';
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
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Container(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 0.0),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "소모임",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 17.0,
                        color: Color(0xff36b6d2)),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "공지 24시간",
                    style: TextStyle(color: Color(0xff393939), fontSize: 10.0),
                  ),
                ],
              )),
          actions: [
            IconButton(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 10.0, right: 10.0),
              onPressed: () {
                Get.to(const ChatListPage());
              },
              icon: const Icon(Icons.menu),
              color: const Color(0xff36b6d2),
            )
          ],
          elevation: 0.0,
          automaticallyImplyLeading: false,
        ),
        body: Container(
            alignment: Alignment.center,
            // padding: const EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
            color: Colors.white,
            child: Expanded(
                flex: 1,
                child: Column(children: [
                  const Divider(thickness: 0.5, color: Color(0xffbbbbbb)),
                  Expanded(
                      child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return todayNotice();
                    },
                  )),
                  Expanded(
                    flex: 3,
                    child: ListView.builder(
                        itemCount: exIndex.length,
                        itemBuilder: (BuildContext context, int index) {
                          return boardList(index);
                        }),
                  )
                ]))));
  }

  Widget todayNotice() {
    return Container(
      width: 124.0,
      height: 148.0,
      margin: const EdgeInsets.fromLTRB(8.0, 5.0, 0.0, 15.0),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(20.0), boxShadow: [
        BoxShadow(
          color: const Color(0xff00b2db).withOpacity(0.3),
          blurRadius: 4.0,
        ),
      ]),
      child: Card(
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          elevation: 0.0,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  backgroundColor: Colors.white),
              onPressed: () {
                Get.to(const MyPage());
              },
              child: Column(
                children: [
                  Container(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            "술 마실 사람 여자 3명임",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13.5,
                                color: Color(0xff595959)),
                          ),
                          const SizedBox(
                            height: 40.0,
                          ),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Icon(
                                        Icons.local_fire_department,
                                        size: 15.0,
                                        color: Color(0xffff2e00),
                                      ),
                                      Text(
                                        "3명",
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  const Text(
                                    "2023.03.16 7시",
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ))
                        ],
                      ))
                ],
              ))),
    );
  }

  Widget boardList(int index) {
    return Column(children: [
      Container(
          height: 50.0,
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        exIndex[index],
                        style: const TextStyle(
                            color: Color(0xff595959),
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600),
                      ),
                      const Text(
                        "3/5",
                        style: TextStyle(
                            fontSize: 12.0,
                            color: Color(0xff3ac7e7),
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 13.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "5명",
                        style: TextStyle(
                            color: Color(0xff999999),
                            fontSize: 12.0,
                            fontWeight: FontWeight.w300),
                      ),
                      Text(
                        "2023.03.16 7시",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Color(0xff595959),
                        ),
                      ),
                    ],
                  )
                ],
              ))),
      const Divider(thickness: 1.0, color: Color(0xffbbbbbb))
    ]);
  }
}
