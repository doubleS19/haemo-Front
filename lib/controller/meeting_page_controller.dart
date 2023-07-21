import 'package:get/get.dart';
import 'package:hae_mo/model/comment_response_model.dart';
import 'package:hae_mo/service/db_service.dart';
import '../model/post_response_model.dart';

class MeetingPageController extends GetxController {
  final DBService dbService = DBService();
  final RxList<PostResponse> todayNoticeList = <PostResponse>[].obs;
  final RxList<PostResponse> postList = <PostResponse>[].obs;
  final RxList<CommentResponse> commentList = <CommentResponse>[].obs;

  void fetchTodayNotice() async {
    try {
      final posts = await dbService.get24HoursPosts();
      todayNoticeList.assignAll(posts);
    } catch (error) {
      // 오류 처리
    }
  }

  void fetchBoardList() async {
    try {
      final posts = await dbService.getAllPost();
      postList.assignAll(posts);
    } catch (error) {
      // 오류 처리
    }
  }

  void fetchCommentList(int pId) async {
    try {
      final comments = await dbService.getCommentsByPId(pId);
      commentList.assignAll(comments);
    } catch (error) {
      // 오류 처리
    }
  }
}
