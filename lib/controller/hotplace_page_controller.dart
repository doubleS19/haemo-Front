import 'package:get/get.dart';
import 'package:hae_mo/controller/wishlist_controller.dart';
import 'package:hae_mo/model/comment_response_model.dart';
import 'package:hae_mo/model/hotplace_post_response_model.dart';
import 'package:hae_mo/model/wish_model.dart';
import 'package:hae_mo/service/db_service.dart';
import '../utils/shared_preference.dart';

class HotPlacePageController extends GetxController {
  final DBService dbService = DBService();
  final RxList<HotPlacePostResponse> popularHotPlaceList =
      <HotPlacePostResponse>[].obs;
  final RxList<HotPlacePostResponse> hotPlacePostList =
      <HotPlacePostResponse>[].obs;
  final RxList<CommentResponse> commentList = <CommentResponse>[].obs;
  late List<HotPlacePostResponse> wishList = <HotPlacePostResponse>[].obs;
  late int uId;

  final Rx<bool> hotPlaceListisLoading = false.obs;

  void getUid() async {
    uId = PreferenceUtil.getInt("uid")!;
  }

  Future<void>fetchWishList(WishListController wishListController) async {
    wishList = await wishListController.getWishList();
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
    for (HotPlacePostResponse item in wishList) {
      if (item.pId == pId) {
        return true;
      }
    }
    return false;
  }


  /// 찜 클릭 시 유저의 핫플 리스트에 핫플 추가 & 삭제
  void updateWishList(int pId, bool checkWishList) {
    if (checkWishList) {
      dbService.deleteWishList(uId, pId);
    } else {
      dbService.addWishList(Wish(pId: pId, uId: uId));
    }
  }
}
