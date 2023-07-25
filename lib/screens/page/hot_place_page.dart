import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hae_mo/common/color.dart';
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
        padding: const EdgeInsets.all(30),
        alignment: Alignment.center,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("현재, 가장 인기있는 핫플"),
            Expanded(
                flex: 2,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  // Enable horizontal scrolling
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        color: Colors.green,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text("갯골생태공원 이미지"));
                  },
                )),
            Text("장소들.."),
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.yellow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget popularHotPlaceCard() {
  return Card();
}
