import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hae_mo/common/color.dart';
import 'package:hae_mo/controller/board/attend_controller.dart';
import 'package:hae_mo/controller/club_page_controller.dart';
import 'package:hae_mo/controller/comment_controller.dart';
import 'package:hae_mo/controller/hotplace_page_controller.dart';
import 'package:hae_mo/controller/meeting_page_controller.dart';
import 'package:hae_mo/controller/user_controller.dart';
import 'package:hae_mo/model/acceptation_response_model.dart';
import 'package:hae_mo/model/club_post_response_model.dart';
import 'package:hae_mo/model/hotplace_post_response_model.dart';
import 'package:hae_mo/model/post_response_model.dart';
import 'package:hae_mo/model/user_response_model.dart';
import 'package:hae_mo/screens/components/commentWidget.dart';
import 'package:hae_mo/screens/components/customAppBar.dart';
import 'package:hae_mo/screens/components/customDialog.dart';
import 'package:hae_mo/screens/components/userProfileWidget.dart';
import 'package:hae_mo/service/db_service.dart';
import 'dart:developer' as dev;
import 'package:hae_mo/utils/shared_preference.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardDetailPage extends StatefulWidget {
  const BoardDetailPage(
      {super.key,
      required this.pId,
      required this.type,
      this.meetingPost,
      this.clubPost,
      this.hotPlacePost});

  final int pId;
  final int type;
  final PostResponse? meetingPost;
  final ClubPostResponse? clubPost;
  final HotPlacePostResponse? hotPlacePost;

  @override
  State<BoardDetailPage> createState() => _BoardDetailPageState();
}

class _BoardDetailPageState extends State<BoardDetailPage> {
  double _textFieldHeight = 40.0;
  UserResponse? _postUser;
  UserController userController = UserController();
  MeetingPageController meetingController = MeetingPageController();
  ClubPageController clubPageController = ClubPageController();
  HotPlacePageController hotPlacePageController = HotPlacePageController();
  AttendController attendController = AttendController();
  CommentController commentController = CommentController();
  TextEditingController textController = TextEditingController();
  late AcceptionState _acceptionState;
  late Color _buttonColor;
  late Color _borderColor;
  late Color _buttonTextColor;
  late String _buttonText;
  late int _attendNum;
  DBService db = DBService();
  final FocusNode _focusNode = FocusNode();
  bool isReply = false;
  int cId = 0;

  @override
  void dispose() {
    textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.type == 1) {
      attendController.fetchAttendList(widget.pId);
      attendController.checkState(PreferenceUtil.getInt("uId")!, widget.pId);
      _borderColor = AppTheme.mainColor;
      _buttonColor = Colors.white;
      _buttonTextColor = AppTheme.mainColor;
      _buttonText = "명단 확인";
      _attendNum = 0;
      _acceptionState = AcceptionState.nonParticipation;
    }
  }

  @override
  Widget build(BuildContext context) {
    userController.fetchBoardUser(widget.pId, widget.type);

    final title = widget.type == 1
        ? widget.meetingPost?.title
        : (widget.type == 2
            ? widget.clubPost?.title
            : widget.hotPlacePost?.title);

    final content = widget.type == 1
        ? widget.meetingPost?.content
        : (widget.type == 2
            ? widget.clubPost?.content
            : widget.hotPlacePost?.content);

    final date = widget.type == 1
        ? widget.meetingPost?.date
        : (widget.type == 2
            ? widget.clubPost?.date
            : widget.hotPlacePost?.date);

    var activeIndex = 0;

    if (widget.hotPlacePost != null &&
        widget.hotPlacePost!.photoList.isNotEmpty) {
      print("photoList: ${widget.hotPlacePost!.photoList}");
    }

    Widget indicator() => Container(
        margin: const EdgeInsets.only(bottom: 20.0),
        alignment: Alignment.bottomCenter,
        child: AnimatedSmoothIndicator(
          activeIndex: activeIndex,
          count: widget.hotPlacePost?.photoList.length ?? 0,
          effect: JumpingDotEffect(
              dotHeight: 6,
              dotWidth: 6,
              activeDotColor: Colors.white,
              dotColor: Colors.white.withOpacity(0.6)),
        ));

    Widget imageSlider(path, index) => Container(
          width: double.infinity,
          height: 240,
          color: Colors.grey,
          child: Image.network(path, fit: BoxFit.cover),
        );

    return Obx(() {
      _postUser = userController.user.value;

      if (_postUser == null) {
        return const Text("잠시 후 다시 시도해 주세요.");
      } else {
        if (widget.type == 1) {
          attendController.acceptList
              .removeWhere((element) => element.isAccepted == false);
          _attendNum = attendController.acceptList.length;
          attendController.fetchAttendList(widget.pId);
          if (_postUser!.uId != PreferenceUtil.getInt("uId")) {
            _acceptionState = attendController.acceptionState;
            _buttonColor = attendController.buttonColor.value;
            _buttonTextColor = attendController.buttonTextColor.value;
            _buttonText = attendController.buttonText.value;
          }
        }
        // 댓글 목록
        return GestureDetector(
            onTap: () {
              _focusNode.unfocus();
              if (commentController.isReply.value == true) {
                replyDialog(context, "대댓글 작성을 중지하시겠습니까?", "취소", "확인", () {
                  commentController.cId.value = 0;
                  commentController.isReply.value = false;
                  textController.clear();
                }, () {
                  _focusNode.requestFocus();
                });
                dev.log("cId 0이어야 됨: ${commentController.cId.value}");
              }
            },
            child: Scaffold(
                body: Scaffold(
                    body: Scaffold(
                        resizeToAvoidBottomInset: false,
                        appBar: (_postUser!.uId == PreferenceUtil.getInt("uId")
                            ? boardWriterAppbar()
                            : boardDetailAppbar(widget.type, widget.pId)),
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
                                userProfile(context, _postUser!, date!),
                                const SizedBox(height: 30.0),
                                Text(
                                  title!,
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    color: AppTheme.mainTextColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 15.0),
                                if (widget.type == 2 &&
                                    widget.clubPost?.logo != null) ...[
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height *
                                        0.25,
                                    child: Image.network(
                                      widget.clubPost!.logo!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                ] else if (widget.type == 3 &&
                                    widget.hotPlacePost?.photoList.length !=
                                        0) ...[
                                  Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.25,
                                      child: Stack(
                                          alignment: Alignment.bottomCenter,
                                          children: <Widget>[
                                            CarouselSlider.builder(
                                              options: CarouselOptions(
                                                initialPage: 0,
                                                viewportFraction: 1,
                                                enlargeCenterPage: true,
                                                onPageChanged:
                                                    (index, reason) =>
                                                        setState(() {
                                                  activeIndex = index;
                                                }),
                                              ),
                                              itemCount: widget.hotPlacePost!
                                                  .photoList.length,
                                              itemBuilder:
                                                  (context, index, realIndex) {
                                                final path = widget
                                                    .hotPlacePost!
                                                    .photoList[index];
                                                return imageSlider(path, index);
                                              },
                                            ),
                                            Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: indicator())
                                          ]))
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
                                        content!,
                                        style: const TextStyle(
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
                                  Column(
                                    children: [
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                              margin: const EdgeInsets.only(
                                                  right: 10.0),
                                              child: Text(
                                                  "$_attendNum/${widget.meetingPost?.person}",
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: AppTheme
                                                          .mainColor)))),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 0.5,
                                                      color:
                                                          AppTheme.mainColor),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          23.0),
                                                  color: _borderColor),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  5,
                                              height: MediaQuery.sizeOf(context)
                                                      .height /
                                                  31,
                                              child: MaterialButton(
                                                color: _buttonColor,
                                                elevation: 0.0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18.0),
                                                    side: BorderSide(
                                                        color: _borderColor)),
                                                child: Text(
                                                  _buttonText,
                                                  style: TextStyle(
                                                      fontSize: 10.8,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: _buttonTextColor),
                                                ),
                                                onPressed: () async {
                                                  if (_postUser!.uId ==
                                                      PreferenceUtil.getInt(
                                                          "uId")) {
                                                    List<UserResponse>
                                                        userList = await db
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
                                                            PreferenceUtil
                                                                .getInt("uId")!,
                                                            widget.pId);
                                                  }
                                                },
                                              ))),
                                    ],
                                  )
                                ],
                                const Divider(color: AppTheme.mainTextColor),
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
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.0,
                                            color: AppTheme.mainTextColor),
                                        cursorColor: AppTheme.mainPageTextColor,
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
                            ]))))));
      }
    });
  }
}

// Widget postInfo(String title, String content, String date, List<String>? imageList) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         title,
//         style: TextStyle(
//           fontSize: 18.0,
//           color: AppTheme.mainTextColor,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//       const SizedBox(height: 15.0),
//       Text(
//         content,
//         style: TextStyle(
//           color: AppTheme.mainTextColor,
//           fontWeight: FontWeight.w400,
//         ),
//       ),
//       const SizedBox(height: 20.0),
//       Text(
//         date,
//         style: TextStyle(
//           color: AppTheme.mainTextColor,
//           fontWeight: FontWeight.w400,
//         ),
//       ),
//     ],
//   );
// }
