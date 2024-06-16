import 'package:flutter/material.dart';
import 'package:haemo/common/color.dart';
import 'package:haemo/controller/hotplace_page_controller.dart';
import 'package:haemo/model/hotplace_post_response_model.dart';
import 'package:haemo/screens/Page/board/hot_place_page.dart';
import 'package:haemo/service/db_service.dart';
import 'package:haemo/utils/shared_preference.dart';

class MyWishPlacePage extends StatefulWidget {
  const MyWishPlacePage({super.key});

  @override
  State<MyWishPlacePage> createState() => _MyWishPlacePageState();
}

class _MyWishPlacePageState extends State<MyWishPlacePage> {
  List<HotPlacePostResponse> postList = [];

  @override
  void initState() {
    super.initState();
  }

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
              const Divider(
                color: AppTheme.dividerColor,
                thickness: 0.5,
              ),
              Expanded(flex: 3, child: myWishList(postList))
            ])));
  }

  Widget myWishList(List<HotPlacePostResponse> postList) {
    if (postList.isEmpty) {
      return const Center(child: Text("찜한 장소가 없습니다."));
    } else {
      return GridView.builder(
          itemCount: postList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.4,
              mainAxisSpacing: 20,
              crossAxisSpacing: 10),
          itemBuilder: (BuildContext context, int index) {
            return hotPlaceCard(
                context,
                HotPlacePostResponse(
                    pId: postList[index].pId,
                    title: postList[index].title,
                    content: postList[index].content,
                    address: postList[index].address,
                    nickname: postList[index].nickname,
                    date: postList[index].date,
                    photoList: [],
                    heartNum: postList[index].heartNum),
                PreferenceUtil.getInt("uId")!);
          });
    }
  }
}
