import 'package:get/get.dart';
import 'package:hae_mo/service/db_service.dart';
import '../utils/shared_preference.dart';

class WishListController extends GetxController {

  final DBService dbService = DBService();
  final RxList<int> wishList = RxList<int>();
  late int uId = PreferenceUtil.getInt("uid")!;

  WishListController(){
    getWishList(); // getWishList 함수 호출
  }

  void getWishList() async {
    var wishResponseList = await dbService.getWishListByUser(uId);
    print("wishResponseList: ${wishList.toString()}");

    for (var i in wishResponseList){
      wishList.add(i.pId);
    }
  }
}