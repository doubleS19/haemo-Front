import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haemo/model/club_post_response_model.dart';
import 'package:haemo/model/comment_model.dart';
import 'package:haemo/model/comment_response_model.dart';
import 'package:haemo/model/reply_model.dart';
import 'package:haemo/model/user_response_model.dart';
import 'package:haemo/model/wish_meeting_response_model.dart';
import 'package:haemo/screens/components/customDialog.dart';
import 'package:haemo/screens/page/board/board_detail_page.dart';
import 'package:haemo/service/date_service.dart';
import 'package:haemo/service/db_service.dart';
import '../model/post_response_model.dart';
import 'dart:developer' as dev;

enum CommentState { success, fail, empty, okay }

enum ReplyState { success, fail, empty, okay }

class MeetingPageController extends GetxController {
  CommentState _commentState = CommentState.fail;
  ReplyState _replyState = ReplyState.fail;

  CommentState get commentState => _commentState;
  ReplyState get replyState => _replyState;

  final DBService dbService = DBService();
  final RxList<PostResponse> todayNoticeList = <PostResponse>[].obs;
  final RxList<PostResponse> postList = <PostResponse>[].obs;
  final RxList<PostResponse> detailPost = <PostResponse>[].obs;
  PostResponse? detailPostResponse;
  late List<int> wishMeetingListPId = <int>[].obs;
  late List<WishMeetingResponse> wishMeetingList = <WishMeetingResponse>[].obs;
  late int _boardPerson = 0;

  int get boardPerson => _boardPerson;

  void fetchTodayNotice() async {
    final posts = await dbService.get24HoursPosts();
    todayNoticeList.assignAll(posts);
    update();
  }

  void fetchBoardList() async {
    final posts = await dbService.getAllPost();
    postList.assignAll(posts);
    update();
  }

  // void fetchPostPerson(int pId) async {
  //   try {
  //     final detail = await dbService.getPostById(pId);
  //     dev.log("펄슨은요: ${detail.person.toString()}");
  //     int person = detail.person;
  //     _boardPerson = person;
  //   } catch (error) {
  //     print(error.toString());
  //   }
  // }

  Future fetchPostByPId(int pId) async {
    final post = await dbService.getPostById(pId);
    detailPostResponse = post;
    update();
  }

  Future<UserResponse> fetchBoardUser(String nickname) async {
    final user = await dbService.getUserByNickname(nickname);
    return user;
  }

  Future<bool> checkIsWished(int uId, int pId) {
    return dbService.checkWishMeetingExist(uId, pId);
  }
}
