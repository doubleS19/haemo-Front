import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hae_mo/common/color.dart';
import 'package:hae_mo/controller/meeting_page_controller.dart';
import 'package:hae_mo/model/club_post_model.dart';
import 'package:hae_mo/model/user_response_model.dart';
import 'package:hae_mo/screens/components/commentWidget.dart';
import '../../model/comment_response_model.dart';
import '../../model/post_model.dart';
import '../../service/db_service.dart';
import '../components/heartButton.dart';

class BoardDetailPage extends StatefulWidget {
  const BoardDetailPage({super.key, required this.pId, required this.type});

  final int pId;
  final int type;

  @override
  State<BoardDetailPage> createState() => _BoardDetailPageState();
}

class _BoardDetailPageState extends State<BoardDetailPage> {
  MeetingPageController meetingController = MeetingPageController();
  bool fillHeartColor = false;

  @override
  Widget build(BuildContext context) {
    DBService db = DBService();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          elevation: 0.0,
          automaticallyImplyLeading: true,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Divider(
              color: AppTheme.mainColor,
              thickness: 1.0,
            ),
            if (widget.type == 1) ...[
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
                                commentWidget(widget.pId, widget.type),
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
            ] else ...[
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
                                commentWidget(widget.pId, widget.type),
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
          ]),
        ),
        bottomNavigationBar: Container(
            // 밑에 고정된 버튼
            width: double.infinity,
            height: 70.0,
            color: AppTheme.mainColor, // 원하는 배경색상 설정
            child: Align(
                alignment: Alignment.center,
                child: Row(children: [
                  Expanded(
                      flex: 1,
                      child: IconButton(
                          onPressed: () {
                            if (fillHeartColor) {
                              fillHeartColor = false;
                            }
                          },
                          icon: HeartButtonWidget(fillHeart: fillHeartColor))),
                  Expanded(
                      flex: 1,
                      child: IconButton(
                          onPressed: () {
                            if (fillHeartColor) {
                              fillHeartColor = false;
                            }
                          },
                          icon: HeartButtonWidget(fillHeart: fillHeartColor)))
                ]))));
  }
}
