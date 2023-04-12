import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hae_mo/Page/my_page.dart';
import 'package:hae_mo/page/chat_list_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/post_model.dart';
import '../service/db_service.dart';

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
  final List<String> exIndex = <String>[
    "5명이서 술 마실 사람?",
    "나랑 혜화역 갈 사람? 살 게 있어",
    "놀자놀자놀자ㅇ",
    "존잘남이랑 사귈 사람?",
    "곧 벚꽃 시즌인데 꽃놀이 갈 사람",
    "핫뜌",
    "영화 볼 사람",
    "2:2 미팅 할 건데 여자 구해용",
    "야 진짜 배고프지 않냐 밥 먹자",
    "치킨 기프티콘 있는데 혼자 먹긴 좀 ㅜ",
    "알고리즘 듣는 사람",
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
                    "친구 구하는 페이지",
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
                  Expanded(flex: 3, child: boardList())
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

  Widget boardList() {
    DBService db = DBService();
    return FutureBuilder(
        future: db.fetchPost(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Post> postList = snapshot.data as List<Post>;
            return ListView.builder(
                itemCount: postList.length,
                itemBuilder: (BuildContext context, int index) {
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      postList[index].title,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${postList[index].person}명",
                                      style: const TextStyle(
                                          color: Color(0xff999999),
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    const Text(
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
                });
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
