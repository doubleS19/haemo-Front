import 'package:get/get.dart';
import 'package:hae_mo/service/db_service.dart';
import '../model/club_post_response_model.dart';

class WishListController extends GetxController {

  final DBService dbService = DBService();
  final RxList<int> wishList = RxList<int>();
  late Rx<int> uId = 0.obs;

  WishListController(int uId){
    this.uId.value = uId;
    getWishList();

  }

  void getWishList() async {
    var wishResponseList = await dbService.getWishListByUser(uId.value);
    for (var i in wishResponseList){
      wishList.add(i.pId);
    }
  }

}
