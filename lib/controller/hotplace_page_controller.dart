import 'package:get/get.dart';
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
  late RxList<HotPlacePostResponse> wishList = <HotPlacePostResponse>[].obs;
  late int uId;

  final Rx<bool> hotPlaceListisLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    // 여기에서 uId를 초기화합니다.
    uId = PreferenceUtil.getInt("uid")!;

    updateWishList();
  }

  Future<void> updateWishList() async {
    var wishResponseList = await dbService.getWishListByUser(uId);

    wishList.assignAll(wishResponseList);
  }

  void updateHotPlaceList() {
    print("updateHotPlaceList 실행");
    hotPlaceListisLoading.value = false;
    fetchPopularHotPlaceList();
    fetchHotPlaceList();
    updateWishList();
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
}
