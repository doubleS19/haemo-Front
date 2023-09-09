import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as dev;
import 'package:hae_mo/common/color.dart';
import 'package:hae_mo/controller/board/attend_controller.dart';
import 'package:hae_mo/controller/club_page_controller.dart';
import 'package:hae_mo/controller/meeting_page_controller.dart';
import 'package:hae_mo/model/club_post_model.dart';
import 'package:hae_mo/model/user_response_model.dart';
import 'package:hae_mo/screens/components/commentWidget.dart';
import 'package:hae_mo/screens/components/customDialog.dart';
import 'package:hae_mo/screens/components/userProfileWidget.dart';
import 'package:hae_mo/screens/components/wishStarButton.dart';
import 'package:hae_mo/utils/shared_preference.dart';
import '../../../model/post_model.dart';
import '../../../service/db_service.dart';
import '../../components/heartButton.dart';
import '../../components/userBottomSheet.dart';

class BoardDetailPage extends StatefulWidget {
  const BoardDetailPage({super.key, required this.pId, required this.type});

  final int pId;
  final int type;

  @override
  State<BoardDetailPage> createState() => _BoardDetailPageState();
}

class _BoardDetailPageState extends State<BoardDetailPage> {
  double _textFieldHeight = 35.0;
  MeetingPageController meetingController = MeetingPageController();
  ClubPageController clubPageController = ClubPageController();
  TextEditingController commentController = TextEditingController();
  final AttendController _attendController = Get.put(AttendController());
  late AcceptionState _acceptionState;

  DBService db = DBService();

  @override
  void initState() {
    _attendController.checkState(PreferenceUtil.getInt("uId")!, widget.pId);
    _acceptionState = _attendController.acceptionState;
    dev.log(_acceptionState.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AttendController>(builder: (_attendController) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            elevation: 0.0,
            automaticallyImplyLeading: true,
            actions: [
              if (widget.type == 1) ...[
                FutureBuilder<bool>(
                  future: meetingController.checkIsWished(
                    PreferenceUtil.getInt("uId")!,
                    widget.pId,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // 데이터가 로딩 중일 때 표시할 위젯
                      return CircularProgressIndicator(); // 예시로 로딩 스피너를 사용했습니다.
                    } else if (snapshot.hasError) {
                      // 에러가 발생한 경우 표시할 위젯
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      // 데이터가 없는 경우나 null인 경우 표시할 위젯
                      return Text('Data not available');
                    } else {
                      // 데이터가 정상적으로 로드된 경우 표시할 위젯
                      final bool fillHeartColor = snapshot.data!;
                      return WishStarButton(
                          fillHeart: fillHeartColor,
                          uId: PreferenceUtil.getInt("uId")!,
                          pId: widget.pId,
                          type: widget.type);
                    }
                  },
                )
              ] else ...[
                FutureBuilder<bool>(
                  future: clubPageController.checkIsWished(
                    PreferenceUtil.getInt("uId")!,
                    widget.pId,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // 데이터가 로딩 중일 때 표시할 위젯
                      return CircularProgressIndicator(); // 예시로 로딩 스피너를 사용했습니다.
                    } else if (snapshot.hasError) {
                      // 에러가 발생한 경우 표시할 위젯
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      // 데이터가 없는 경우나 null인 경우 표시할 위젯
                      return Text('Data not available');
                    } else {
                      // 데이터가 정상적으로 로드된 경우 표시할 위젯
                      final bool fillHeartColor = snapshot.data!;
                      return WishStarButton(
                          fillHeart: fillHeartColor,
                          uId: PreferenceUtil.getInt("uId")!,
                          pId: widget.pId,
                          type: widget.type);
                    }
                  },
                )
              ]
            ],
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
                                  userProfile(context, user),
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
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                          margin: EdgeInsets.only(right: 10.0),
                                          child: Text(
                                            "3/3",
                                            style: TextStyle(
                                                color: AppTheme.mainColor,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w700),
                                          ))),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 0.5,
                                                  color: _attendController
                                                      .borderColor.value),
                                              borderRadius:
                                                  BorderRadius.circular(23.0),
                                              color: _attendController
                                                  .buttonColor.value),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              5,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              31,
                                          child: MaterialButton(
                                            color: Colors.transparent,
                                            elevation: 0.0,
                                            child: Text(
                                              _attendController
                                                  .buttonText.value,
                                              style: TextStyle(
                                                  fontSize: 10.8,
                                                  fontWeight: FontWeight.w500,
                                                  color: _attendController
                                                      .textColor.value),
                                            ),
                                            onPressed: () async {
                                              if (user.uId ==
                                                  PreferenceUtil.getInt(
                                                      "uId")) {
                                                List<UserResponse> userList =
                                                    await db.getAttendUserList(
                                                        widget.pId);
                                                return showAttendUserDialog(
                                                    context,
                                                    userList,
                                                    userList.length,
                                                    _attendController,
                                                    widget.pId);
                                              } else {
                                                _attendController
                                                    .requestParticipation(
                                                        context,
                                                        PreferenceUtil.getInt(
                                                            "uId")!,
                                                        widget.pId);
                                              }
                                            },
                                          ))),
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
                                      SizedBox(
                                          width: 41.0,
                                          height: 41.0,
                                          child: RawMaterialButton(
                                              elevation: 0.0,
                                              fillColor: Colors.transparent,
                                              shape: CircleBorder(),
                                              onPressed: (() {
                                                userBottomSheet(context, user);
                                              }),
                                              child: Container(
                                                width: 41,
                                                height: 41,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.transparent,
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        user.userImage),
                                                  ),
                                                ),
                                              ))),
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
              margin: EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(children: [
                Expanded(
                    flex: 7,
                    child: Container(
                        margin: EdgeInsets.fromLTRB(0.0, 20.0, 5.0, 25.0),
                        height: _textFieldHeight,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.82),
                            color: AppTheme.receiverText),
                        child: TextField(
                          expands: true,
                          controller: commentController,
                          maxLines: null,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                              color: AppTheme.mainTextColor),
                          cursorColor: AppTheme.mainPageTextColor,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          decoration: InputDecoration(
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              border: InputBorder.none,
                              hintText: "댓글을 작성해 주세요.",
                              hintStyle: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.fontSize,
                                  fontFamily: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.fontFamily,
                                  color:
                                      AppTheme.postingPageDetailHintTextColor)),
                        ))),
                IconButton(
                    onPressed: () {},
                    icon: SizedBox(
                        width: 33.0,
                        height: 33.0,
                        child: RawMaterialButton(
                            elevation: 0.0,
                            fillColor: AppTheme.mainColor,
                            shape: const CircleBorder(),
                            onPressed: (() {}),
                            child: Container(
                              width: 41,
                              height: 41,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                                image: DecorationImage(
                                  image: AssetImage(
                                      "assets/icons/send_comment_icon.png"),
                                ),
                              ),
                            )))),
              ])));
    });
  }
}
