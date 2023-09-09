import 'package:get/get.dart';
import 'package:hae_mo/model/hotplace_post_response_model.dart';
import 'package:hae_mo/service/db_service.dart';
import '../utils/shared_preference.dart';

class WishListController extends GetxController {

  final DBService dbService = DBService();
  final RxList<int> wishList = RxList<int>();
  late int uId = PreferenceUtil.getInt("uid")!;

  Future<List<HotPlacePostResponse>> getWishList() async {
    var wishResponseList = await dbService.getWishListByUser(uId);

    return wishResponseList;
  }
}