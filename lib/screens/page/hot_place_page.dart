import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hae_mo/model/hotplace_post_response_model.dart';
import 'package:hae_mo/model/user_response_model.dart';
import 'package:hae_mo/service/db_service.dart';
import '../../common/theme.dart';
import '../../controller/hotplace_page_controller.dart';
import '../../model/wish_model.dart';
import '../components/customAppBar.dart';
import '../components/heartButton.dart';

class HotPlacePage extends StatefulWidget {
  const HotPlacePage({super.key});

  @override
  State<HotPlacePage> createState() => _HotPlacePageState();
}

class _HotPlacePageState extends State<HotPlacePage> {
  final HotPlacePageController hotPlaceController =
      Get.find<HotPlacePageController>();

  @override
  void initState() {
    super.initState();
    hotPlaceController.fetchPopularHotPlaceList();
    hotPlaceController.fetchHotPlaceList();
    hotPlaceController.tmp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customMainAppbar("핫플", "공지 24시간"),
      body: Container(
        padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
        alignment: Alignment.center,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("현재, 가장 인기있는 핫플",
                style: CustomThemes.hotPlaceSubTitleTextStyle),
            SizedBox(
                height: MediaQuery.of(context).size.height / 3.5,
                child:
                    Obx(() => hotPlaceController.popularHotPlaceList.isNotEmpty
                        ? ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                hotPlaceController.popularHotPlaceList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 15, 15),
                                  alignment: Alignment.center,
                                  child: popularHotPlaceCard(
                                      context,
                                      hotPlaceController
                                          .popularHotPlaceList[index],
                                      hotPlaceController));
                            },
                          )
                        : Center(child: Text("인기 게시물이 존재하지 않습니다. ")))),
            Text("장소들..", style: CustomThemes.hotPlaceSubTitleTextStyle),
            Expanded(
                child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Obx(() => GridView.builder(
                        itemCount: hotPlaceController.hotPlacePostList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.4,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 10),
                        itemBuilder: (BuildContext context, int index) {
                          return hotPlaceCard(
                              context,
                              hotPlaceController.hotPlacePostList.value[index],
                              hotPlaceController
                              /*hotPlaceController.hotPlacePostList[index],
                                  hotPlaceController.hpWishList.contains(hotPlaceController.hotPlacePostList[index].pId)*/
                              );
                        })))),
          ],
        ),
      ),
    );
  }
}

Widget popularHotPlaceCard(
    BuildContext context,
    HotPlacePostResponse hotPlaceData,
    HotPlacePageController hotPlacePageController) {
  bool fillHeartColor = hotPlacePageController.wishList.contains(hotPlaceData.pId);
  return Container(
      width: MediaQuery.of(context).size.width / 2,
      //height: MediaQuery.of(context).size.width / 2 * 3,
      decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4), BlendMode.darken),
              image: const AssetImage("assets/images/sunset.jpg"),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(12.0)),
      child: Stack(children: [
        Positioned(
          bottom: 50,
          left: 10,
          child:
              /// 글자 제한 두고 디자인 신경쓰기
              Text(hotPlaceData.title,
                  style: CustomThemes.hotPlacePopularTitleTextStyle),
        ),
        Positioned(
            right: 0,
            child: HeartButtonWidget(
                    fillHeart: fillHeartColor,
                    onClick: () {
                      hotPlacePageController.updateWishList(
                          hotPlaceData.pId, fillHeartColor);
                      print("클림됨: ${fillHeartColor}");
                    })),
        Positioned(
            bottom: 30,
            left: 10,
            child: Text(hotPlaceData.content,
                style: CustomThemes.hotPlacePopularSubtitleTextStyle)),
      ]));
}

Widget hotPlaceCard(BuildContext context, HotPlacePostResponse hotPlaceData,
    HotPlacePageController hotPlacePageController) {
  bool fillHeartColor = hotPlacePageController.wishList.contains(hotPlaceData.pId);

  return Container(
      width: MediaQuery.of(context).size.width / 2.3,
      height: MediaQuery.of(context).size.height / 8,
      decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4), BlendMode.darken),
              image: AssetImage("assets/images/sunset.jpg"),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(12.0)),
      child: Stack(children: [
        Positioned(
          bottom: 10,
          left: 10,
          child: Text(hotPlaceData.title,
              style: CustomThemes.hotPlaceTitleTextStyle),
        ),
        Positioned(
          right: 0,
          child: IconButton(
              onPressed: () {
                // db.addWishList(Wish(uId: user.uId, pId: hotPlaceData.pId));
              },
              icon: HeartButtonWidget(
                  fillHeart: fillHeartColor,
                  onClick: () {
                    hotPlacePageController.updateWishList(
                        hotPlaceData.pId, fillHeartColor);
                    print("클림됨: ${fillHeartColor}");
                  })),
        )
      ]));
}
