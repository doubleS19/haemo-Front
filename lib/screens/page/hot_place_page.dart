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
        alignment: Alignment.center,
        color: Colors.white,
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }


}
