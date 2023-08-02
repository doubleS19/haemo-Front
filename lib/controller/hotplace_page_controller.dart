import 'package:get/get.dart';
import 'package:hae_mo/model/comment_response_model.dart';
import 'package:hae_mo/model/hotplace_post_response_model.dart';
import 'package:hae_mo/service/db_service.dart';
import '../model/post_response_model.dart';

class HotPlacePageController extends GetxController {
  final DBService dbService = DBService();
  final RxList<HotPlacePostResponse> popularHotPlaceList = <HotPlacePostResponse>[].obs;
  final RxList<HotPlacePostResponse> hotPlacePostList = <HotPlacePostResponse>[].obs;
  final RxList<CommentResponse> commentList = <CommentResponse>[].obs;

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
}
