import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hae_mo/model/shared_preference.dart';
import 'package:hae_mo/model/user_response_model.dart';
import 'package:hae_mo/screens/page/chat_list_page.dart';
import 'package:hae_mo/screens/page/chat_room_page.dart';
import 'package:hae_mo/screens/page/my_meeting_page.dart';
import 'package:hae_mo/service/db_service.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  var myPageList = ["내가 작성한 글", "찜한 장소", "가고 싶은 모임"];
  @override
  Widget build(BuildContext context) {
    DBService db = DBService();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          elevation: 0.0,
          title: const Text(
            "마이 페이지",
            style: TextStyle(
              color: Color(0xff595959),
              fontSize: 19.0,
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: FutureBuilder(
            future: db.getUserByNickname(PreferenceUtil.getString("nickname")!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final UserResponse user = snapshot.data as UserResponse;
                return Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    child: Column(children: [
                      const Divider(color: Color(0xff595959)),
                      const Text(
                        "프로필",
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Color(0xff818181),
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                            color: const Color(0xffe3e3e3),
                            borderRadius: BorderRadius.circular(15.0)),
                        alignment: Alignment.center,
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        user.major,
                        style: const TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        user.nickname,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      const Divider(color: Color(0xff595959)),
                      InkWell(
                          onTap: () {
                            Get.to(() => const MyMeetingPage());
                          },
                          child: Container(
                              width: double.infinity,
                              height: 44.0,
                              margin: const EdgeInsets.only(left: 20.0),
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                "내가 작성한 글",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w300,
                                    color: Color(0xff393939)),
                              ))),
                      const Divider(color: Color(0xff595959)),
                      InkWell(
                          onTap: () {
                            Get.to(() => const ChatRoom(
                                  chatRoomId: '3',
                                ));
                          },
                          child: Container(
                            width: double.infinity,
                            height: 44.0,
                            margin: const EdgeInsets.only(left: 20.0),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              "찜한 장소",
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w300,
                                  color: Color(0xff393939)),
                            ),
                          )),
                      const Divider(color: Color(0xff595959)),
                      InkWell(
                          onTap: () {
                            Get.to(() => const ChatRoom(
                                  chatRoomId: '3',
                                ));
                          },
                          child: Container(
                            width: double.infinity,
                            height: 44.0,
                            margin: const EdgeInsets.only(left: 20.0),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              "가고 싶은 모임",
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w300,
                                  color: Color(0xff393939)),
                            ),
                          ))
                    ]));
              } else {
                return const Center(
                    child: Text("회원 정보를 불러오는데 실패했습니다.\n다시 시도해주세요."));
              }
            }));
  }

  Widget myList() {
    return ListView.builder(
        itemCount: myPageList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {
                Get.to(() => const ChatListPage());
              },
              child: Column(children: [
                Container(
                    height: 50.0,
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(children: [
                          Text(
                            myPageList[index],
                            style: const TextStyle(
                                color: Color(0xff595959),
                                fontSize: 13.5,
                                fontWeight: FontWeight.w600),
                          ),
                          const Divider(
                              thickness: 1.0, color: Color(0xffbbbbbb))
                        ])))
              ]));
        });
  }
}