import 'package:get/get.dart';
import 'package:hae_mo/service/db_service.dart';
import '../model/post_response_model.dart';

class MeetingPageController extends GetxController {
  final DBService dbService = DBService();
  final RxList<PostResponse> todayNoticeList = <PostResponse>[].obs;
  final RxList<PostResponse> clubList = <PostResponse>[].obs;

  void fetchTodayNotice() async {
    try {
      final posts = await dbService.get24HoursPosts();
      posts.removeWhere((element) => element.type == 2);
      todayNoticeList.assignAll(posts);
    } catch (error) {
      // 오류 처리
    }
  }

  void fetchBoardList() async {
    try {
      final posts = await dbService.getAllPost();
      posts.removeWhere((element) => element.type == 2);
      clubList.assignAll(posts);
    } catch (error) {
      // 오류 처리
    }
  }
}
