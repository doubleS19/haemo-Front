import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hae_mo/model/comment_model.dart';
import 'package:hae_mo/model/comment_response_model.dart';
import 'package:hae_mo/model/wish_meeting_response_model.dart';
import 'package:hae_mo/screens/components/customDialog.dart';
import 'package:hae_mo/screens/page/board/board_detail_page.dart';
import 'package:hae_mo/service/date_service.dart';
import 'package:hae_mo/service/db_service.dart';
import '../model/post_response_model.dart';
import 'dart:developer' as dev;

enum CommentState { success, fail, empty, okay }

class MeetingPageController extends GetxController {
  CommentState _commentState = CommentState.fail;

  CommentState get commentState => _commentState;

  final DBService dbService = DBService();
  final RxList<PostResponse> todayNoticeList = <PostResponse>[].obs;
  final RxList<PostResponse> postList = <PostResponse>[].obs;
  final RxList<CommentResponse> commentList = <CommentResponse>[].obs;
  late List<int> wishMeetingListPId = <int>[].obs;
  late List<WishMeetingResponse> wishMeetingList = <WishMeetingResponse>[].obs;

  void fetchTodayNotice() async {
    try {
      final posts = await dbService.get24HoursPosts();
      todayNoticeList.assignAll(posts);
    } catch (error) {
      print(error.toString());
    }
  }

  void fetchBoardList() async {
    try {
      final posts = await dbService.getAllPost();
      postList.assignAll(posts);
    } catch (error) {
      print(error.toString());
    }
  }

  Future<bool> checkIsWished(int uId, int pId) {
    return dbService.checkWishMeetingExist(uId, pId);
  }

  Future checkCommentValid(String nickname, String content, int pId, int type,
      BuildContext context) async {
    if (content != "" && content.isEmail == false) {
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
    bool isUserSaved = await dbService.sendComment(comment);
    if (isUserSaved) {
      _commentState = CommentState.success;
      Get.back();
      Get.to(BoardDetailPage(pId: pId, type: type));
    } else {
      _commentState = CommentState.fail;
    }

    update();
  }
}
