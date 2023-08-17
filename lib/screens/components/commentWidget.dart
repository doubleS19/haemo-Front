import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hae_mo/common/color.dart';
import 'package:hae_mo/model/user_response_model.dart';
import 'package:hae_mo/screens/components/userBottomSheet.dart';

import '../../model/club_comment_response_model.dart';
import '../../model/comment_response_model.dart';
import '../../model/hotplace_comment_response_model.dart';
import '../../service/db_service.dart';


/// Type: 1 - metting, 2 - club, 3 - hotplace
Widget commentWidget(int pId, int type) {
  DBService db = DBService();
  if (type == 1) {
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
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("댓글 0",
                    style: TextStyle(
                        color: Color(0xff040404), fontWeight: FontWeight.w500)),
                SizedBox(height: 30.0),
                Center(
                  child: Text(
                    "댓글이 없어요!",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                  ),
                )
              ]);
        } else {
          // 댓글 목록
          final commentList = snapshot.data!;
          return Column(children: [
            Row(children: [
              const Text("댓글 ",
                  style: TextStyle(
                      color: Color(0xff040404), fontWeight: FontWeight.w500)),
              Text(commentList.length.toString(),
                  style: const TextStyle(
                      color: Color(0xff040404), fontWeight: FontWeight.w500)),
            ]),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: commentList.length,
              itemBuilder: (BuildContext context, int index) {
                return FutureBuilder<UserResponse>(
                  future: db.getUserByNickname(commentList[index].nickname),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (userSnapshot.hasError) {
                      return const Text("유저 정보를 불러오는 중 오류가 발생했습니다.");
                    } else if (userSnapshot.hasData) {
                      final user = userSnapshot.data!;
                      return Column(
                        children: [
                          Container(
                            height: 50.0,
                            width: double.infinity,
                            margin:
                                const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(children: [
                                  SizedBox(
                                      width: 41.0,
                                      height: 41.0,
                                      child: RawMaterialButton(
                                          elevation: 0.0,
                                          fillColor: Colors.transparent,
                                          shape: const CircleBorder(),
                                          onPressed: (() {
                                            userBottomSheet(context, user);
                                          }),
                                          child: Container(
                                            width: 41,
                                            height: 41,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppTheme.mainTextColor,
                                              image: DecorationImage(
                                                image:
                                                    AssetImage(user.userImage),
                                              ),
                                            ),
                                          ))),
                                  const SizedBox(width: 10.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        commentList[index].nickname,
                                        style: TextStyle(
                                          color: AppTheme.mainTextColor,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        commentList[index].content,
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: AppTheme.mainTextColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ])),
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                );
              },
            )
          ]);
        }
      },
    );
  } else if (type == 2) {
    return FutureBuilder<List<ClubCommentResponse>>(
      future: db.getClubCommentsByCpId(pId),
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
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("댓글 0",
                    style: TextStyle(
                        color: Color(0xff040404), fontWeight: FontWeight.w500)),
                SizedBox(height: 30.0),
                Center(
                  child: Text(
                    "댓글이 없어요!",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                  ),
                )
              ]);
        } else {
          // 댓글 목록
          final commentList = snapshot.data!;
          return Column(children: [
            Row(children: [
              const Text("댓글 ",
                  style: TextStyle(
                      color: Color(0xff040404), fontWeight: FontWeight.w500)),
              Text(commentList.length.toString(),
                  style: const TextStyle(
                      color: Color(0xff040404), fontWeight: FontWeight.w500)),
            ]),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: commentList.length,
              itemBuilder: (BuildContext context, int index) {
                return FutureBuilder<UserResponse>(
                  future: db.getUserByNickname(commentList[index].nickname),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (userSnapshot.hasError) {
                      return const Text("유저 정보를 불러오는 중 오류가 발생했습니다.");
                    } else if (userSnapshot.hasData) {
                      final user = userSnapshot.data!;
                      return Column(
                        children: [
                          Container(
                            height: 50.0,
                            width: double.infinity,
                            margin:
                                const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(children: [
                                  SizedBox(
                                      width: 41.0,
                                      height: 41.0,
                                      child: RawMaterialButton(
                                          elevation: 0.0,
                                          fillColor: Colors.transparent,
                                          shape: const CircleBorder(),
                                          onPressed: (() {
                                            userBottomSheet(context, user);
                                          }),
                                          child: Container(
                                            width: 41,
                                            height: 41,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppTheme.mainTextColor,
                                              image: DecorationImage(
                                                image:
                                                    AssetImage(user.userImage),
                                              ),
                                            ),
                                          ))),
                                  const SizedBox(width: 10.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        commentList[index].nickname,
                                        style: TextStyle(
                                          color: AppTheme.mainTextColor,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        commentList[index].content,
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: AppTheme.mainTextColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ])),
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                );
              },
            )
          ]);
        }
      },
    );
  } else {
    return FutureBuilder<List<HotPlaceCommentResponse>>(
      future: db.getHotPlaceCommentsByHpId(pId),
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
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("댓글 0",
                    style: TextStyle(
                        color: Color(0xff040404), fontWeight: FontWeight.w500)),
                SizedBox(height: 30.0),
                Center(
                  child: Text(
                    "댓글이 없어요!",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                  ),
                )
              ]);
        } else {
          // 댓글 목록
          final commentList = snapshot.data!;
          return Column(children: [
            Row(children: [
              const Text("댓글 ",
                  style: TextStyle(
                      color: Color(0xff040404), fontWeight: FontWeight.w500)),
              Text(commentList.length.toString(),
                  style: const TextStyle(
                      color: Color(0xff040404), fontWeight: FontWeight.w500)),
            ]),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: commentList.length,
              itemBuilder: (BuildContext context, int index) {
                return FutureBuilder<UserResponse>(
                  future: db.getUserByNickname(commentList[index].nickname),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (userSnapshot.hasError) {
                      return const Text("유저 정보를 불러오는 중 오류가 발생했습니다.");
                    } else if (userSnapshot.hasData) {
                      final user = userSnapshot.data!;
                      return Column(
                        children: [
                          Container(
                            height: 50.0,
                            width: double.infinity,
                            margin:
                                const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(children: [
                                  SizedBox(
                                      width: 41.0,
                                      height: 41.0,
                                      child: RawMaterialButton(
                                          elevation: 0.0,
                                          fillColor: Colors.transparent,
                                          shape: const CircleBorder(),
                                          onPressed: (() {
                                            userBottomSheet(context, user);
                                          }),
                                          child: Container(
                                            width: 41,
                                            height: 41,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppTheme.mainTextColor,
                                              image: DecorationImage(
                                                image:
                                                    AssetImage(user.userImage),
                                              ),
                                            ),
                                          ))),
                                  const SizedBox(width: 10.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        commentList[index].nickname,
                                        style: TextStyle(
                                          color: AppTheme.mainTextColor,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        commentList[index].content,
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: AppTheme.mainTextColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ])),
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                );
              },
            )
          ]);
        }
      },
    );
  }
}
