import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hae_mo/common/color.dart';
import 'package:hae_mo/common/user_image.dart';
import 'package:hae_mo/controller/comment_controller.dart';
import 'package:hae_mo/model/user_response_model.dart';
import 'package:hae_mo/screens/components/replyWidget.dart';
import 'package:hae_mo/screens/components/userBottomSheet.dart';
import '../../model/comment_response_model.dart';
import '../../service/db_service.dart';
import 'dart:developer' as dev;

class CommentWidget extends StatefulWidget {
  const CommentWidget(
      {super.key,
      required this.type,
      required this.pId,
      required this.onReplyPressed});
  final int pId;
  final int type;
  final Function onReplyPressed;

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  CommentController commentController = CommentController();
  DBService db = DBService();
  late List<CommentResponse> commentList;
  late List<UserResponse> userList;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    commentController.fetchCommentList(widget.pId, widget.type);
    commentController.fetchUser(widget.pId, widget.type);
    return Obx(() {
      commentList = commentController.commentList;
      userList = commentController.users;
      if (commentList.isEmpty) {
        // 댓글이 없는 경우
        return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
        return Column(children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text("댓글 ${commentList.length}",
                  style: const TextStyle(
                      color: Color(0xff040404), fontWeight: FontWeight.w500))),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: userList.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(children: [
                  Container(
                      height: 50.0,
                      width: double.infinity,
                      margin: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                flex: 7,
                                child: Row(children: [
                                  SizedBox(
                                      width: 41.0,
                                      height: 41.0,
                                      child: RawMaterialButton(
                                          elevation: 0.0,
                                          fillColor: Colors.transparent,
                                          shape: const CircleBorder(),
                                          onPressed: (() {
                                            userBottomSheet(
                                                context, userList[index]);
                                          }),
                                          child: Container(
                                            width: 41,
                                            height: 41,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.transparent,
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    userRoundImage[
                                                        userList[index]
                                                            .userImage]),
                                              ),
                                            ),
                                          ))),
                                  const SizedBox(width: 10.0),
                                  Expanded(
                                      flex: 7,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                      )),
                                  const SizedBox(width: 15.0),
                                ])),
                            Expanded(
                                flex: 2,
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 0.5,
                                                color: Colors.transparent),
                                            borderRadius:
                                                BorderRadius.circular(23.0),
                                            color: const Color(0xffededed)),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                7,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                32,
                                        child: MaterialButton(
                                          color: Colors.transparent,
                                          elevation: 0.0,
                                          child: Text(
                                            "답글",
                                            style: TextStyle(
                                                fontSize: 8.0,
                                                fontWeight: FontWeight.w500,
                                                color: AppTheme.mainTextColor),
                                          ),
                                          onPressed: () {
                                            widget.onReplyPressed(
                                                commentList[index].cId);
                                          },
                                        ))))
                          ])),
                  ReplyWidget(
                    cId: commentList[index].cId,
                    type: widget.type,
                  ),
                  Divider(
                    color: AppTheme.commentDividerColor,
                    height: 0.5,
                  )
                ]);
              })
        ]);
      }
    });
  }
}
