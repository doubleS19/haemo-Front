import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hae_mo/common/color.dart';
import 'package:hae_mo/model/hotplace_post_response_model.dart';
import '../../common/theme.dart';
import '../../controller/club_page_controller.dart';
import '../components/customAppBar.dart';
import 'board_detail_page.dart';
import 'chat_list_page.dart';
import 'club_board_detail_page.dart';

class HotPlacePage extends StatefulWidget {
  const HotPlacePage({super.key});

  @override
  State<HotPlacePage> createState() => _HotPlacePageState();
}

class _HotPlacePageState extends State<HotPlacePage> {
  //final HotPlaceController hotPlaceController = Get.find<HotPlaceController>();

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
            Expanded(
                flex: 4,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        padding: const EdgeInsets.fromLTRB(0, 15, 15, 15),
                        alignment: Alignment.center,
                        child: popularHotPlaceCard(
                            context,
                            HotPlacePostResponse(
                                pId: "pId",
                                title: "title",
                                content: "content",
                                nickname: "nickname",
                                date: "date",
                                photoList: [],
                                heartNum: 2)));
                  },
                )),
            Text("장소들..", style: CustomThemes.hotPlaceSubTitleTextStyle),
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: GridView.builder(
                    itemCount: 5,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio:1.4,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 10
                    ), itemBuilder: (BuildContext context, int index) {
                  return Expanded(
                      child: hotPlaceCard(
                          context,
                          HotPlacePostResponse(
                              pId: "pId",
                              title: "title",
                              content: "content",
                              nickname: "nickname",
                              date: "date",
                              photoList: [],
                              heartNum: 2)));
                })
              )

            ),
          ],
        ),
      ),
    );
  }
}

Widget popularHotPlaceCard(
    BuildContext context, HotPlacePostResponse hotPlaceData) {
  return Container(
      width: MediaQuery.of(context).size.width / 2,
      //height: MediaQuery.of(context).size.width / 2 * 3,
      decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4), BlendMode.darken),
              image: AssetImage("assets/images/sunset.jpg"),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(12.0)),
      child: Stack(children: [
        Positioned(
          bottom: 50,
          left: 10,
          child:  /// 글자 제한 두고 디자인 신경쓰기
              Text("갯골생태공원", style: CustomThemes.hotPlacePopularTitleTextStyle),
        ),
        Positioned(
          right: 0,
          child:
          IconButton(
              onPressed: () {
              },
              icon: const Icon(
                CupertinoIcons.heart_fill,
                color: Colors.red,
              )),        ),
        Positioned(
          bottom: 30,
          left: 10,
          child:
          Text("이색 데이터 어쩌고", style: CustomThemes.hotPlacePopularSubtitleTextStyle)
        ),
      ]));
}

Widget hotPlaceCard(BuildContext context, HotPlacePostResponse hotPlaceData){
  bool isRed = false;

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
      child: Stack(
          children: [
        Positioned(
          bottom: 10,
          left: 10,
          child:
          Text("갯골생태공원", style: CustomThemes.hotPlaceTitleTextStyle),
        ),
        Positioned(
          right: 0,
          child:
          IconButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered)) {
                      return Colors.redAccent; //<-- SEE HERE
                    }
                    return null; // Defer to the widget's default.
                  },
                ),
              ),
              onPressed: () {

              },
              icon: const Icon(
                CupertinoIcons.heart_fill,
                color: Colors.white,
              ))),
      ]));
}