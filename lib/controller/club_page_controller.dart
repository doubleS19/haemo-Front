import 'package:get/get.dart';
import 'package:hae_mo/service/db_service.dart';
import '../model/post_response_model.dart';

class ClubPageController extends GetxController {
  var postListLength = 0.obs;

  void setPostListLength(int length) {
    postListLength.value = length;
  }

  final DBService dbService = DBService();
  final RxList<PostResponse> todayNoticeList = <PostResponse>[].obs;
  final RxList<PostResponse> clubList = <PostResponse>[].obs;

  void fetchTodayNotice() async {
    try {
      final posts = await dbService.get24HoursPosts();
      posts.removeWhere((element) => element.type == 1);
      todayNoticeList.assignAll(posts);
    } catch (error) {
      // 오류 처리
    }
  }

  void fetchClubList() async {
    try {
      final posts = await dbService.getAllPost();
      posts.removeWhere((element) => element.type == 1);
      clubList.assignAll(posts);
    } catch (error) {
      // 오류 처리
    }
  }
}
