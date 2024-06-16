import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haemo/model/comment_model.dart';
import 'package:haemo/model/comment_response_model.dart';
import 'package:haemo/model/reply_model.dart';
import 'package:haemo/model/reply_response_model.dart';
import 'package:haemo/model/user_response_model.dart';
import 'package:haemo/screens/components/customDialog.dart';
import 'package:haemo/screens/page/board/board_detail_page.dart';
import 'package:haemo/service/date_service.dart';
import 'package:haemo/service/db_service.dart';
import 'dart:developer' as dev;

enum CommentState { success, fail, empty, okay }

enum ReplyState { success, fail, empty, okay }

class CommentController extends GetxController {
  CommentState _commentState = CommentState.fail;
  ReplyState _replyState = ReplyState.fail;

  CommentState get commentState => _commentState;
  ReplyState get replyState => _replyState;

  final DBService dbService = DBService();
  final RxList<CommentResponse> commentList = <CommentResponse>[].obs;
  final RxList<ReplyResponse> replyList = <ReplyResponse>[].obs;
  final RxList<UserResponse> userList = <UserResponse>[].obs;
  RxBool isReply = false.obs;
  RxInt cId = 0.obs;

  List<UserResponse> get users => userList;

  Future checkCommentValid(String nickname, String content, int pId, int type,
      BuildContext context) async {
    if (content != "" && content.isEmpty == false) {
      _commentState = CommentState.okay;
      saveComment(nickname, content, pId, type);
      dev.log("Okay~");
    } else {
      _commentState = CommentState.empty;
      showMyAlertDialog(context, "댓글의 내용을 작성해 주세요.", "댓글의 내용을 작성해 주세요.", () {
        Get.back();
      });
      dev.log("Empty~");
    }
    update();
  }

  Future saveComment(String nickname, String content, int pId, int type) async {
    DBService dbService = DBService();

    Comment comment = Comment(
        nickname: nickname,
        content: content,
        date: getNow(),
        pId: pId,
        type: type == 1
            ? CommentType.Post
            : (type == 2 ? CommentType.Club : CommentType.HotPlace));
    _commentState = CommentState.success;
    bool isCommentSaved;

    type == 1
        ? isCommentSaved = await dbService.sendComment(comment)
        : (type == 2
            ? isCommentSaved = await dbService.sendClubComment(comment)
            : isCommentSaved = await dbService.sendHotPlaceComment(comment));

    if (isCommentSaved) {
      _commentState = CommentState.success;
    } else {
      _commentState = CommentState.fail;
    }

    update();
  }

  Future checkReplyValid(String nickname, String content, int pId, int cId,
      int type, BuildContext context) async {
    if (content != "" && content.isEmpty == false) {
      _replyState = ReplyState.okay;
      saveReply(nickname, content, pId, cId, type);
      dev.log("Reply Okay~");
    } else {
      _replyState = ReplyState.empty;
      showMyAlertDialog(context, "답글의 내용을 작성해 주세요.", "답글의 내용을 작성해 주세요.", () {
        Get.back();
      });
      dev.log("Reply Empty~");
    }
    update();
  }

  Future saveReply(
      String nickname, String content, int pId, int cId, int type) async {
    DBService dbService = DBService();

    Reply reply = Reply(
        nickname: nickname,
        content: content,
        date: getNow(),
        cId: cId,
        type: ReplyType.Post);
    _replyState = ReplyState.success;
    bool isReplySaved;
    if (type == 1) {
      isReplySaved = await dbService.sendReply(reply);
    } else if (type == 2) {
      isReplySaved = await dbService.sendClubReply(reply);
    } else {
      isReplySaved = await dbService.sendHotPlaceReply(reply);
    }
    if (isReplySaved) {
      _replyState = ReplyState.success;
      isReply = false.obs;
    } else {
      _replyState = ReplyState.fail;
    }
    update();
  }

  void setIsReply(bool value) {
    isReply = value.obs;
    update();
  }

  void setCId(int value) {
    cId = value.obs;
    update();
  }

  void fetchCommentList(int pId, int type) async {
    try {
      late List<CommentResponse> comments;

      type == 1
          ? comments = await dbService.getCommentsByPId(pId)
          : (type == 2
              ? comments = await dbService.getClubCommentsByCpId(pId)
              : (comments = await dbService.getHotPlaceCommentsByHpId(pId)));
      commentList.assignAll(comments);
      dev.log("commentList length: ${commentList.length}");
    } catch (error) {
      print(error.toString());
    }
  }

  void fetchUser(int pId, int type) async {
    try {
      late List<UserResponse> users;

      type == 1
          ? users = await dbService.getCommentUser(pId)
          : (type == 2
              ? users = await dbService.getClubCommentUser(pId)
              : (users = await dbService.getHotPlaceCommentUser(pId)));

      userList.assignAll(users);
      dev.log("userList length: ${userList[userList.length - 1].userImage}");
    } catch (error) {
      print(error.toString());
    }
  }

  void fetchReplyList(int cId, int type) async {
    try {
      late List<ReplyResponse> replys;

      type == 1
          ? replys = await dbService.getReplysByCId(cId)
          : (type == 2
              ? replys = await dbService.getClubReplysByCcId(cId)
              : replys = await dbService.getHotPlaceReplysByHcId(cId));
      replyList.assignAll(replys);
    } catch (e) {
      print(e.toString());
    }
  }
}
