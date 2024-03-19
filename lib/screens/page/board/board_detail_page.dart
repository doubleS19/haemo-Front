import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as dev;
import 'package:hae_mo/common/color.dart';
import 'package:hae_mo/controller/board/attend_controller.dart';
import 'package:hae_mo/controller/club_page_controller.dart';
import 'package:hae_mo/controller/comment_controller.dart';
import 'package:hae_mo/controller/meeting_page_controller.dart';
import 'package:hae_mo/controller/user_controller.dart';
import 'package:hae_mo/model/club_post_model.dart';
import 'package:hae_mo/model/user_response_model.dart';
import 'package:hae_mo/screens/components/commentWidget.dart';
import 'package:hae_mo/screens/components/customAppBar.dart';
import 'package:hae_mo/screens/components/customDialog.dart';
import 'package:hae_mo/screens/components/userProfileWidget.dart';
import 'package:hae_mo/utils/shared_preference.dart';
import '../../../model/post_model.dart';
import '../../../service/db_service.dart';

class BoardDetailPage extends StatefulWidget {
  const BoardDetailPage({super.key, required this.pId, required this.type});

  final int pId;
  final int type;

  @override
  State<BoardDetailPage> createState() => _BoardDetailPageState();
}

class _BoardDetailPageState extends State<BoardDetailPage> {
  double _textFieldHeight = 40.0;
  MeetingPageController meetingController = MeetingPageController();
  ClubPageController clubPageController = ClubPageController();
  CommentController commentController = CommentController();
  TextEditingController textController = TextEditingController();
  final AttendController _attendController = Get.put(AttendController());
  UserController userController = UserController();
  late AcceptionState _acceptionState;
  final FocusNode _focusNode = FocusNode();
  bool isReply = false;
  int cId = 0;
  DBService db = DBService();
  Future? future;
  dynamic model;

  @override
  void initState() {
    _attendController.checkState(PreferenceUtil.getInt("uId")!, widget.pId);
    _acceptionState = _attendController.acceptionState;
    _attendController.fetchAttendUserList(widget.pId);
    widget.type == 1 ? model = Post : model = ClubPost;
    dev.log(_acceptionState.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    meetingController.fetchPostPerson(widget.pId);

    widget.type == 1
        ? future = db.getPostById(widget.pId)
        : future = db.getClubPostById(widget.pId);

    // return Obx(() {
    return GestureDetector(onTap: () {
      _focusNode.unfocus();
      if (commentController.isReply.value == true) {
        if (textController.text.isEmpty) {
          commentController.cId.value = 0;
          commentController.isReply.value = false;
        } else {
          replyDialog(context, "대댓글 작성을 중지하시겠습니까?", "취소", "확인", () {
            commentController.cId.value = 0;
            commentController.isReply.value = false;
            textController.clear();
          }, () {
            _focusNode.requestFocus();
          });
        }
        dev.log("cId 0이어야 됨: ${commentController.cId.value}");
      }
    }, child: Scaffold(body: Scaffold(
        body: GetBuilder<AttendController>(builder: (attendController) {
      return FutureBuilder(
          future: future!,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // 데이터가 로딩 중일 때 표시할 위젯
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // 에러가 발생한 경우 표시할 위젯
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data == null) {
              // 데이터가 없는 경우나 null인 경우 표시할 위젯
              return const Text('Data not available');
            } else {
              var post;
              widget.type == 1
                  ? post = snapshot.data as Post
                  : post = snapshot.data as ClubPost;

              userController.fetchBoardUser(widget.pId, widget.type);

              Future? userFuture;
              widget.type == 1
                  ? userFuture = db.getUserByPost(widget.pId)
                  : userFuture = db.getUserByClubPost(widget.pId);

              // 데이터가 정상적으로 로드된 경우 표시할 위젯
              return FutureBuilder(
                  future: userFuture,
                  builder: (context, snapshot) {
                    dev.log(snapshot.connectionState.toString());
                    if (snapshot.hasData) {
                      final UserResponse user = snapshot.data as UserResponse;
                      attendController.setUserList(
                          PreferenceUtil.getInt("uId")!, widget.pId);
                      return Scaffold(
                          resizeToAvoidBottomInset: false,
                          appBar: (user.uId == PreferenceUtil.getInt("uId")
                              ? boardWriterAppbar()
                              : boardDetailAppbar(meetingController,
                                  clubPageController, widget.type, widget.pId)),
                          body: SingleChildScrollView(
                              child: Column(children: [
                            Divider(
                              color: AppTheme.mainColor,
                              thickness: 1.0,
                            ),
                            Container(
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
                                  const SizedBox(height: 15.0),
                                  if (widget.type == 2 &&
                                      post.logo != null) ...[
                                    SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      child: Image.memory(post.logo),
                                    )
                                  ],
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
                                  if (widget.type == 1) ...[
                                    Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                            margin: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Text(
                                              "${attendController.acceptList.length}/${meetingController.boardPerson}",
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
                                                    color: attendController
                                                        .borderColor.value),
                                                borderRadius:
                                                    BorderRadius.circular(23.0),
                                                color: attendController
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
                                                attendController
                                                    .buttonText.value,
                                                style: TextStyle(
                                                    fontSize: 10.8,
                                                    fontWeight: FontWeight.w500,
                                                    color: attendController
                                                        .textColor.value),
                                              ),
                                              onPressed: () async {
                                                if (user.uId ==
                                                    PreferenceUtil.getInt(
                                                        "uId")) {
                                                  List<UserResponse> userList =
                                                      await db
                                                          .getAttendUserList(
                                                              widget.pId);

                                                  // ignore: use_build_context_synchronously
                                                  return showAttendUserDialog(
                                                      context,
                                                      userList,
                                                      userList.length,
                                                      attendController,
                                                      widget.pId);
                                                } else {
                                                  attendController
                                                      .requestParticipation(
                                                          context,
                                                          PreferenceUtil.getInt(
                                                              "uId")!,
                                                          widget.pId);
                                                }
                                              },
                                            ))),
                                  ],
                                  Divider(color: AppTheme.mainTextColor),
                                  CommentWidget(
                                    pId: widget.pId,
                                    type: widget.type,
                                    onReplyPressed: (int cId) {
                                      _focusNode.requestFocus();
                                      commentController.cId.value = cId;
                                      commentController.isReply.value = true;
                                    },
                                  ),
                                ],
                              ),
                            )
                          ])),
                          bottomNavigationBar: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(children: [
                                Expanded(
                                    flex: 7,
                                    child: Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            0.0, 20.0, 5.0, 25.0),
                                        height: _textFieldHeight,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30.82),
                                            color: AppTheme.receiverText),
                                        child: AutoSizeTextField(
                                          minFontSize: 14.0,
                                          maxFontSize: 14.0,
                                          focusNode: _focusNode,
                                          controller: textController,
                                          maxLines: 5,
                                          minLines: 1,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.0,
                                              color: AppTheme.mainTextColor),
                                          cursorColor:
                                              AppTheme.mainPageTextColor,
                                          keyboardType: TextInputType.multiline,
                                          textInputAction:
                                              TextInputAction.newline,
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 10.0),
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
                                                  color: AppTheme
                                                      .postingPageDetailHintTextColor)),
                                        ))),
                                IconButton(
                                    onPressed: () {},
                                    icon: Obx(() {
                                      return SizedBox(
                                          width: 33.0,
                                          height: 33.0,
                                          child: RawMaterialButton(
                                              elevation: 0.0,
                                              fillColor: AppTheme.mainColor,
                                              shape: const CircleBorder(),
                                              onPressed: (() {
                                                dev.log(
                                                    "cId는,,,,,, ${commentController.cId.value}");
                                                if (commentController.isReply ==
                                                    false.obs) {
                                                  commentController
                                                      .checkCommentValid(
                                                          PreferenceUtil
                                                              .getString(
                                                                  "nickname")!,
                                                          textController.text,
                                                          widget.pId,
                                                          widget.type,
                                                          context);
                                                } else {
                                                  commentController
                                                      .checkReplyValid(
                                                          PreferenceUtil
                                                              .getString(
                                                                  "nickname")!,
                                                          textController.text,
                                                          widget.pId,
                                                          commentController
                                                              .cId.value,
                                                          widget.type,
                                                          context);
                                                }
                                                setState(() {
                                                  textController.clear();
                                                });
                                              }),
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
                                              )));
                                    })),
                              ])));
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
          });
    }))));
  }
}
