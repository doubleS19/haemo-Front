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

  // }계획 대로 되는ㄴ게 없어서 첫만남은 너무어려워 매일 드는 말야~ 예에에에 예ㅔ앙아에ㅔㅇ 예ㅖ~
  //  애애애애애애~~ 둥

  Future fetchClubPostList() async {
    final postList = await dbService.getAllClubPost();
    clubList.assignAll(postList);
    print(clubList);
    update();
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
