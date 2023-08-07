import 'package:get/get.dart';
import 'package:hae_mo/model/comment_response_model.dart';
import 'package:hae_mo/model/hotplace_post_response_model.dart';
import 'package:hae_mo/service/db_service.dart';
import '../model/post_response_model.dart';

class HotPlacePageController extends GetxController {
  final DBService dbService = DBService();
  final RxList<HotPlacePostResponse> popularHotPlaceList =
      <HotPlacePostResponse>[].obs;
  final RxList<HotPlacePostResponse> hotPlacePostList =
      <HotPlacePostResponse>[].obs;
  final RxList<CommentResponse> commentList = <CommentResponse>[].obs;
  late List<String> hpWishList = <String>[];

  HotPlacePageController() {
    dbService.getWishList().then((value) => hpWishList = value);
  }

  void fetchPopularHotPlaceList() async {
    try {
      final hotplacePosts = await dbService.getPopularHotPlacePosts();
      popularHotPlaceList.assignAll(hotplacePosts);
    } catch (error) {
      // 오류 처리
    }
  }

  void fetchHotPlaceList() async {
    try {
      final posts = await dbService.getAllHotPlacePost();
      hotPlacePostList.assignAll(posts);
    } catch (error) {
      // 오류 처리
    }
  }

  /// 찜 클릭 시 유저의 핫플 리스트에 핫플 추가 & 삭제
  void updateWishList(String hpId) {
    if (hpWishList.contains(hpId)) {
      /// 찜 목록에 이미 핫플이 존재할 때 -> 찜 취소 -> 핫플 삭제
      hpWishList.remove(hpId);
      dbService.updateHotPlaceToWishList(hpId);
    } else {
      /// 찜 목록에 핫플 추가
      hpWishList.add(hpId);
      dbService.updateHotPlaceToWishList(hpId);
    }
  }


  /// 찜 개수 1 증가

  /// 테이블을 가져올 때 찜 테이블이면 하트 색깔이 빨강색이도록?
}
