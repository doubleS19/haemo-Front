import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hae_mo/common/color.dart';
import 'package:hae_mo/model/hotplace_post_model.dart';
import 'package:hae_mo/model/post_response_model.dart';
import 'package:hae_mo/utils/shared_preference.dart';
import 'package:hae_mo/model/user_response_model.dart';
import 'package:hae_mo/model/wish_model.dart';
import 'package:hae_mo/screens/page/board_detail_page.dart';
import 'package:hae_mo/screens/page/home_page.dart';
import 'package:http/http.dart';
import '../../model/hotplace_post_response_model.dart';
import '../../model/user_model.dart';
import '../../service/db_service.dart';
import '../Page/hot_place_page.dart';

class MyWishPage extends StatefulWidget {
  const MyWishPage({super.key});

  @override
  State<MyWishPage> createState() => _MyWishPageState();
}

class _MyWishPageState extends State<MyWishPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          elevation: 0.0,
          title: const Text(
            "내가 찜한 장소",
            style: TextStyle(
              color: Color(0xff595959),
              fontSize: 19.0,
            ),
          ),
          automaticallyImplyLeading: true,
        ),
        body: Container(
            margin: const EdgeInsets.only(right: 10.0, left: 10.0),
            color: Colors.white,
            child: Column(children: [
              Divider(
                color: AppTheme.dividerColor,
                thickness: 0.5,
              ),
              Expanded(flex: 3, child: myWishList())
            ])));
  }

  Widget myWishList() {
    DBService db = DBService();
    return FutureBuilder(
        future: db.getWishList(1),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Wish> wishList = snapshot.data as List<Wish>;
            UserResponse user =
                db.getUserByNickname(PreferenceUtil.getString("nickname")!)
                    as UserResponse;
            wishList.removeWhere((element) => element.uId != user.uId);
            List<HotPlacePost> postList =
                db.getHotPlaceById(1) as List<HotPlacePost>;

            if (wishList.isEmpty) {
              return Center(
                  child: Text(
                "아직 찜한 장소가 없어요!",
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: AppTheme.mainPageTextColor),
              ));
            } else {
              return ListView.builder(
                  itemCount: postList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          Get.to(() => HomePage());
                        },
                        child: Column(children: [
                          Container(
                              height: 50.0,
                              width: double.infinity,
                              margin:
                                  const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                              padding:
                                  const EdgeInsets.only(left: 5.0, right: 5.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: hotPlaceCard(
                                      context,
                                      HotPlacePostResponse(
                                          pId: 1,
                                          title: postList[index].title,
                                          content: postList[index].content,
                                          address: postList[index].address,
                                          nickname: postList[index].nickname,
                                          date: postList[index].date,
                                          photoList: [],),
                                      true
                                      /*hotPlaceController.hotPlacePostList[index],
                                  hotPlaceController.hpWishList.contains(hotPlaceController.hotPlacePostList[index].pId)*/
                                      )))
                        ]));
                  });
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
