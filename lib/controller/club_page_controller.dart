import 'package:get/get.dart';
import 'package:hae_mo/service/db_service.dart';
import '../model/club_post_response_model.dart';

class ClubPageController extends GetxController {
  var postListLength = 0.obs;

  void setPostListLength(int length) {
    postListLength.value = length;
  }

  final DBService dbService = DBService();
  final RxList<ClubPostResponse> todayNoticeList = <ClubPostResponse>[].obs;
  final RxList<ClubPostResponse> clubList = <ClubPostResponse>[].obs;
  RxList<ClubPostResponse> filteredPosts = <ClubPostResponse>[].obs;

  void fetchClubList() async {
    try {
      final posts = await dbService.getAllClubPost();
      clubList.assignAll(posts);
    } catch (error) {
      // 오류 처리
    }
  }

  Future<bool> checkIsWished(int uId, int pId) {
    return dbService.checkWishClubExist(uId, pId);
  }
}
