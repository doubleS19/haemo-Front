import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hae_mo/model/comment_model.dart';
import 'package:hae_mo/model/comment_response_model.dart';
import 'package:hae_mo/model/reply_model.dart';
import 'package:hae_mo/model/reply_response_model.dart';
import 'package:hae_mo/model/user_response_model.dart';
import 'package:hae_mo/model/wish_meeting_response_model.dart';
import 'package:hae_mo/screens/components/customDialog.dart';
import 'package:hae_mo/screens/page/board/board_detail_page.dart';
import 'package:hae_mo/service/date_service.dart';
import 'package:hae_mo/service/db_service.dart';
import '../model/post_response_model.dart';
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
  RxBool isReply = false.obs;
  RxList<UserResponse> userList = <UserResponse>[].obs;
  RxInt cId = 0.obs;

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

    Comment comment =
        Comment(nickname: nickname, content: content, date: getNow(), pId: pId);
    _commentState = CommentState.success;
    bool isCommentSaved = await dbService.sendComment(comment);
    if (isCommentSaved) {
      _commentState = CommentState.success;
      Get.back();
      Get.to(BoardDetailPage(pId: pId, type: type));
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
      Get.back();
      Get.to(BoardDetailPage(pId: pId, type: type));
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
      if (type == 1) {
        final comments = await dbService.getCommentsByPId(pId);
        commentList.assignAll(comments);
      } else if (type == 2) {
        final comments = await dbService.getClubCommentsByCpId(pId);
        commentList.assignAll(comments);
      } else {
        final comments = await dbService.getHotPlaceCommentsByHpId(pId);
        commentList.assignAll(comments);
      }
      fetchUser(pId, type);
      dev.log("commentList length: ${commentList.length}");
    } catch (error) {
      print(error.toString());
    }
  }

  void fetchUser(int pId, int type) async {
    try {
      if (type == 1) {
        final users = await dbService.getCommentUser(pId);
        userList.assignAll(users);
      } else if (type == 2) {
        final users = await dbService.getClubCommentUser(pId);
        userList.assignAll(users);
      } else {
        final users = await dbService.getHotPlaceCommentUser(pId);
        userList.assignAll(users);
      }
      dev.log("userList length: ${userList.length}");
    } catch (error) {
      print(error.toString());
    }
  }

  // void fetchUser(List<CommentResponse> comments) async {
  //   try {
  //     RxList<UserResponse> users = <UserResponse>[].obs;
  //     for (CommentResponse comment in comments) {
  //       final user = await dbService.getUserByNickname(comment.nickname);
  //       users.add(user);
  //     }
  //     dev.log(users[0].nickname.toString());
  //     userList = users;
  //   } catch (error) {
  //     print(error.toString());
  //   }
  // }

  void fetchReplyList(int cId, int type) async {
    try {
      if (type == 1) {
        final replys = await dbService.getReplysByCId(cId);
        replyList.assignAll(replys);
      } else if (type == 2) {
        final replys = await dbService.getClubReplysByCcId(cId);
        replyList.assignAll(replys);
      } else {
        final replys = await dbService.getHotPlaceReplysByHcId(cId);
        replyList.assignAll(replys);
      }
    } catch (error) {
      print(error.toString());
    }
  }
}
