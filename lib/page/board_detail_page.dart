import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hae_mo/model/post_response_model.dart';
import 'package:hae_mo/model/shared_preference.dart';
import 'package:hae_mo/model/user_response_model.dart';
import 'package:hae_mo/page/chat_list_page.dart';
import 'package:hae_mo/page/chat_room_page.dart';
import 'package:http/http.dart';

import '../controller/posting_controller.dart';
import '../model/post_model.dart';
import '../model/user_model.dart';
import '../service/db_service.dart';

class BoardDetailPage extends StatefulWidget {
  const BoardDetailPage({super.key, required this.pId});

  final int pId;

  @override
  State<BoardDetailPage> createState() => _BoardDetailPageState();
}

class _BoardDetailPageState extends State<BoardDetailPage> {
  @override
  Widget build(BuildContext context) {
    DBService db = DBService();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          elevation: 0.0,
          title: const Text(
            "게시물 조회",
            style: TextStyle(
              color: Color(0xff595959),
              fontSize: 19.0,
            ),
          ),
          automaticallyImplyLeading: true,
        ),
        body: Column(children: [
          const Divider(color: Color(0xff3ac7e7)),
          FutureBuilder(
              future: db.getPostById(widget.pId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final Post post = snapshot.data as Post;
                  return FutureBuilder(
                      future: db.getUserByPost(widget.pId),
                      builder: ((context, snapshot) {
                        if (snapshot.hasData) {
                          final UserResponse user =
                              snapshot.data as UserResponse;
                          return Container(
                              margin: const EdgeInsets.fromLTRB(
                                  20.0, 10.0, 20.0, 0.0),
                              child: Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    post.title,
                                    style: const TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    children: [
                                      Text(user.nickname,
                                          style: const TextStyle(
                                              fontSize: 12.0,
                                              color: Color(0xff999999),
                                              fontWeight: FontWeight.w400)),
                                      const SizedBox(width: 5.0),
                                      Text(user.major,
                                          style: const TextStyle(
                                              fontSize: 12.0,
                                              color: Color(0xff999999),
                                              fontWeight: FontWeight.w400))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  const Divider(color: Color(0xff393939)),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Container(
                                      margin:
                                          const EdgeInsets.only(bottom: 10.0),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      width: double.infinity,
                                      color: const Color(0xff595959)
                                          .withOpacity(0.05),
                                      child: Text(
                                        post.content,
                                        maxLines: 20,
                                      )),
                                  const Divider(color: Color(0xff393939)),
                                  Container(
                                      margin: const EdgeInsets.only(
                                          right: 30, left: 30.0),
                                      height: 45.0,
                                      width: MediaQuery.of(context).size.width,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                            backgroundColor: Color(0xff3ac7e7)),
                                        onPressed: (() {
                                          // Get.to(ChatRoom(
                                          //     chatRoomId:
                                          //         "20191520282019156027"));
                                        }),
                                        child: const Text(
                                          "주문하신 채팅하기 버튼 나왔습니다.",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      )),
                                ],
                              )));
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text("${snapshot.error}"),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }));
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("${snapshot.error}"),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              })
        ]));
  }
}
