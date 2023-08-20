import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hae_mo/common/color.dart';
import 'package:hae_mo/controller/hotplace_page_controller.dart';
import 'package:hae_mo/model/hotplace_post_model.dart';
import 'package:hae_mo/model/post_response_model.dart';
import 'package:hae_mo/model/wish_response_model.dart';
import 'package:hae_mo/utils/shared_preference.dart';
import 'package:hae_mo/model/user_response_model.dart';
import 'package:hae_mo/model/wish_model.dart';
import 'package:hae_mo/screens/page/home_page.dart';
import 'package:http/http.dart';
import '../../model/hotplace_post_response_model.dart';
import '../../model/user_model.dart';
import '../../service/db_service.dart';
import '../Page/board/hot_place_page.dart';

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
      future: db.getWishListHpIdsByUser(PreferenceUtil.getInt("uId")!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Center(child: Text("${snapshot.error}"));
        } else if (snapshot.hasData) {
          final List<int> pIdList = snapshot.data!;
          return FutureBuilder(
            future: db.getHotPlaceById(pIdList[0]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Center(child: Text("${snapshot.error}"));
              } else if (snapshot.hasData) {
                final List<HotPlacePostResponse> postList = snapshot.data!;
                return ListView.builder(
                    itemCount: postList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () {
                            Get.to(() => const HomePage());
                          },
                          child: Column(children: [
                            Container(
                                height: 50.0,
                                width: double.infinity,
                                margin: const EdgeInsets.fromLTRB(
                                    8.0, 8.0, 8.0, 0.0),
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: hotPlaceCard(
                                        context,
                                        HotPlacePostResponse(
                                            pId: postList[index].pId,
                                            title: postList[index].title,
                                            content: postList[index].content,
                                            address: postList[index].address,
                                            nickname: postList[index].nickname,
                                            date: postList[index].date,
                                            photoList: []),
                                        true
                                        /*hotPlaceController.hotPlacePostList[index],
                                  hotPlaceController.hpWishList.contains(hotPlaceController.hotPlacePostList[index].pId)*/
                                        )))
                          ]));
                    });
              } else {
                return Center(child: Text("No data available"));
              }
            },
          );
        } else {
          return const Center(child: Text("No data available"));
        }
      },
    );
  }
}
