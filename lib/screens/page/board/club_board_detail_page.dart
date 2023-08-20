import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hae_mo/common/color.dart';
import 'package:hae_mo/controller/meeting_page_controller.dart';
import 'package:hae_mo/model/club_post_model.dart';
import 'package:hae_mo/model/user_response_model.dart';

import '../../../model/comment_response_model.dart';
import '../../../service/db_service.dart';

class ClubBoardDetailPage extends StatefulWidget {
  const ClubBoardDetailPage({super.key, required this.pId, required this.type});

  final int pId;
  final int type;

  @override
  State<ClubBoardDetailPage> createState() => _ClubBoardDetailPageState();
}

class _ClubBoardDetailPageState extends State<ClubBoardDetailPage> {
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
                future: db.getClubPostById(widget.pId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final ClubPost post = snapshot.data as ClubPost;
                    return FutureBuilder(
                      future: db.getUserByClubPost(widget.pId),
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
                                commentList(widget.pId, widget.type),
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
        ),
        bottomNavigationBar: Container(
            // 밑에 고정된 버튼
            width: double.infinity,
            height: 70.0,
            color: Colors.grey, // 원하는 배경색상 설정
            child: Align(
                alignment: Alignment.center,
                child: Row(children: [
                  Expanded(
                      flex: 1,
                      child: ElevatedButton(
                          onPressed: () {
                            null;
                          },
                          child: Container(
                              width: double.infinity / 2,
                              child: Text("고정된 버튼"),
                              height: 70.0))),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                        onPressed: () {
                          null;
                        },
                        child: Container(
                            width: double.infinity / 2,
                            child: Text("고정된 버튼"),
                            height: 70.0)),
                  )
                ]))));
  }

  Widget commentList(int pId, int type) {
    DBService db = DBService();
    return FutureBuilder<List<CommentResponse>>(
      future: db.getCommentsByPId(pId),
      builder: (context, snapshot) {
        print(snapshot.data);
        if (snapshot.connectionState == ConnectionState.waiting) {
          // 데이터 로딩
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          // 오류
          return const Center(
            child: Text("댓글을 불러오는 중 오류가 발생했습니다."),
          );
        } else if (snapshot.hasData && snapshot.data!.isEmpty) {
          // 댓글이 없는 경우
          return const Center(
            child: Text(
              "댓글이 없어요!",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
            ),
          );
        } else {
          // 댓글 목록
          final commentList = snapshot.data!;
          commentList.removeWhere((element) => element.type != type);
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
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
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(thickness: 1.0, color: Colors.black),
                ],
              );
            },
          );
        }
      },
    );
  }
}
