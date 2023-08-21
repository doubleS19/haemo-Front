import 'package:get/get.dart';
import 'package:hae_mo/controller/wishlist_controller.dart';
import 'package:hae_mo/model/comment_response_model.dart';
import 'package:hae_mo/model/hotplace_post_response_model.dart';
import 'package:hae_mo/model/user_response_model.dart';
import 'package:hae_mo/model/wish_model.dart';
import 'package:hae_mo/model/wish_response_model.dart';
import 'package:hae_mo/service/db_service.dart';
import '../model/post_response_model.dart';
import '../utils/shared_preference.dart';

class HotPlacePageController extends GetxController {
  final DBService dbService = DBService();
  final RxList<HotPlacePostResponse> popularHotPlaceList =
      <HotPlacePostResponse>[].obs;
  final RxList<HotPlacePostResponse> hotPlacePostList =
      <HotPlacePostResponse>[].obs;
  final RxList<CommentResponse> commentList = <CommentResponse>[].obs;
  late List<int> wishList = <int>[].obs;
  late int uId;
  late final WishListController wishListController;

  final Rx<bool> hotPlaceListisLoading = false.obs;

  void tmp() async {
    PreferenceUtil.setString("nickname", "서연이당");

    UserResponse userResponse = await dbService
        .getUserByNickname(PreferenceUtil.getString("nickname")!);
    PreferenceUtil.setInt("uid", userResponse.uId);

    uId = PreferenceUtil.getInt("uid")!;
    wishListController = WishListController(uId);
    ever(wishListController.wishList,
        (callback) => {wishList.assignAll(callback)});
  }

  void updateHotPlaceList() {
    hotPlaceListisLoading.value = false;
    fetchPopularHotPlaceList();
    fetchHotPlaceList();
    hotPlaceListisLoading.value = true;
    update();
    print("hotPlacePostList Length: ${hotPlacePostList.length}");
  }

  void fetchPopularHotPlaceList() async {
    try {
      final hotplacePosts = await dbService.getPopularHotPlacePosts();
      popularHotPlaceList.assignAll(hotplacePosts);
      print("Success to get Popular HotPlaceList: ${hotPlacePostList.length}");
    } catch (error) {
      print("Error to get Popular HotPlaceList: ${error}");
    }
    update();
  }

  void fetchHotPlaceList() async {
    try {
      final posts = await dbService.getAllHotPlacePost();
      hotPlacePostList.assignAll(posts);
      print("Success to get HotPlaceList: ${hotPlacePostList.length}");
    } catch (error) {
      print("Error to get HotPlaceList: ${error}");
    }
  }

  bool checkHotPlaceList(int pId) {
    return wishList.contains(pId);
  }

  /// 찜 클릭 시 유저의 핫플 리스트에 핫플 추가 & 삭제
  void updateWishList(int pId, bool checkWishList) {
    if (checkWishList) {
      /// 찜 목록에 이미 핫플이 존재할 때 -> 찜 취소 -> 핫플 삭제
      dbService.deleteWishList(uId, pId);
    } else {
      /// 찜 목록에 핫플 추가
      dbService.addWishList(Wish(pId: pId, uId: uId));
    }

    /// 위시리스트 업데이트
  }

  /// 테이블을 가져올 때 찜 테이블이면 하트 색깔이 빨강색이도록?
}
