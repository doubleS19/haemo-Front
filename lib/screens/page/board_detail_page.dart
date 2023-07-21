import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hae_mo/common/color.dart';
import 'package:hae_mo/controller/meeting_page_controller.dart';
import 'package:hae_mo/model/user_response_model.dart';
import '../../model/comment_response_model.dart';
import '../../model/post_model.dart';
import '../../service/db_service.dart';

class BoardDetailPage extends StatefulWidget {
  const BoardDetailPage({super.key, required this.pId});

  final int pId;

  @override
  State<BoardDetailPage> createState() => _BoardDetailPageState();
}

class _BoardDetailPageState extends State<BoardDetailPage> {
  MeetingPageController meetingController = MeetingPageController();

  @override
  Widget build(BuildContext context) {
    DBService db = DBService();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          elevation: 0.0,
          title: Text(
            "게시물 조회",
            style: TextStyle(
              color: AppTheme.mainAppBarColor,
              fontSize: 19.0,
            ),
          ),
          automaticallyImplyLeading: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Divider(
                color: AppTheme.mainColor,
                thickness: 1.0,
              ),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 41,
                                      height: 41,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppTheme.mainTextColor,
                                        image: const DecorationImage(
                                          image: AssetImage(
                                              'assets/images/sunset.jpg'),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10.0),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          user.nickname,
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: AppTheme.mainTextColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${user.major}  /  ',
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: AppTheme.mainTextColor,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                              user.gender,
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: AppTheme.mainTextColor,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 30.0),
                                Text(
                                  post.title,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: AppTheme.mainTextColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Divider(color: AppTheme.mainTextColor),
                                const SizedBox(height: 10.0),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10.0),
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 20.0),
                                      Text(
                                        post.content,
                                        style: TextStyle(
                                          color: AppTheme.mainTextColor,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        maxLines: 20,
                                      ),
                                      const SizedBox(height: 20.0),
                                    ],
                                  ),
                                ),
                                Divider(color: AppTheme.mainTextColor),
                                commentList(widget.pId),
                              ],
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text("${snapshot.error}"),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("${snapshot.error}"),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ));
  }

  Widget commentList(int pId) {
    DBService db = DBService();
    return FutureBuilder<List<CommentResponse>>(
      future: db.getCommentsByPId(pId),
      builder: (context, snapshot) {
        print(snapshot.data);
        if (snapshot.connectionState == ConnectionState.waiting) {
          // 데이터를 기다리는 동안 로딩 중 화면을 보여줍니다.
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          // 오류가 발생한 경우 오류 메시지를 보여줍니다.
          return const Center(
            child: Text("댓글을 불러오는 중 오류가 발생했습니다."),
          );
        } else if (snapshot.hasData && snapshot.data!.isEmpty) {
          // 데이터를 성공적으로 받아왔지만 댓글이 없는 경우
          return Center(
            child: Text(
              "댓글이 없어요!",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
            ),
          );
        } else {
          // 정상적으로 데이터를 받아온 경우 댓글 목록을 보여줍니다.
          final commentList = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true, // 추가
            physics: NeverScrollableScrollPhysics(), // 추가
            itemCount: commentList.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Container(
                    height: 50.0,
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          Text(
                            commentList[index].nickname,
                            style: const TextStyle(
                              color: Color(0xff999999),
                              fontSize: 12.0,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            commentList[index].content,
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(thickness: 1.0, color: Colors.black),
                ],
              );
            },
          );
        }
      },
    );
  }
}
