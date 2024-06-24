import 'package:get/get.dart';
import 'package:haemo/model/club_post_response_model.dart';
import 'package:haemo/model/hotplace_post_response_model.dart';
import 'package:haemo/model/user_response_model.dart';
import 'package:haemo/service/db_service.dart';
import 'package:haemo/utils/shared_preference.dart';
import '../model/post_response_model.dart';
import 'dart:developer' as dev;

class WishController extends GetxController {
  final DBService dbService = DBService();
  final uId = PreferenceUtil.getInt('uId');
  final RxList<PostResponse> wishMeetingPost = <PostResponse>[].obs;
  final RxList<ClubPostResponse> wishClubPost = <ClubPostResponse>[].obs;
  final RxList<HotPlacePostResponse> wishHotPlacePost =
      <HotPlacePostResponse>[].obs;

  void fetchWishMeetingPost() async {
    final posts = await dbService.getWishMeetingListByUser(uId!);
    wishMeetingPost.assignAll(posts);
    update();
  }

  void fetchWishClubPost() async {
    final posts = await dbService.getWishClubListByUser(uId!);
    wishClubPost.assignAll(posts);
    print(posts.obs.toString());
    update();
  }

  void fetchWishHotPlacePost() async {
    final posts = await dbService.getWishListByUser(uId!);
    wishHotPlacePost.assignAll(posts);
    update();
  }
}
