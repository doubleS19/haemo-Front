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
  late int uId;
  final Rx<bool> hotPlaceListisLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    uId = PreferenceUtil.getInt("uId")!;
    updateHotPlaceList();
  }

  void updateHotPlaceList() {
    hotPlaceListisLoading.value = false;
    fetchPopularHotPlaceList();
    fetchHotPlaceList();
    hotPlaceListisLoading.value = true;
    update();
  }

  Future fetchPopularHotPlaceList() async {
    final hotplacePosts = await dbService.getPopularHotPlacePosts();
    popularHotPlaceList.assignAll(hotplacePosts);
    print("Success to get Popular HotPlaceList: ${hotPlacePostList.length}");
    update();
  }

  Future fetchHotPlaceList() async {
    final posts = await dbService.getAllHotPlacePost();
    hotPlacePostList.assignAll(posts);
    print("Success to get HotPlaceList: ${hotPlacePostList.length}");
    update();
  }
}
