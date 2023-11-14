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

  void updateFilteredPosts(String query) {
    if (query.isEmpty) {
      // 검색어가 비어있을 때, 전체 목록을 보여줌
      filteredPosts.assignAll(clubList);
    } else {
      // 검색어가 있을 때, 해당 검색어를 포함하는 게시물만 필터링
      final filtered =
          clubList.where((post) => post.title.contains(query)).toList();
      filteredPosts.clear(); // 기존 목록 비우기
      filteredPosts.addAll(filtered); // 필터링된 항목 추가
    }
  }
}
