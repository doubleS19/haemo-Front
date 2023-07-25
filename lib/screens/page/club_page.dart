import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hae_mo/common/color.dart';
import '../../controller/club_page_controller.dart';
import '../components/customAppBar.dart';
import 'board_detail_page.dart';
import 'chat_list_page.dart';
import 'club_board_detail_page.dart';

class ClubPage extends StatefulWidget {
  const ClubPage({super.key});

  @override
  State<ClubPage> createState() => _ClubPageState();
}

class _ClubPageState extends State<ClubPage> {
  final ClubPageController clubController = Get.find<ClubPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customMainAppbar("소모임/동아리 게시판", "공지 24시간" ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: 13.0,
              margin: const EdgeInsets.only(left: 40.0),
              alignment: Alignment.centerLeft,
              child: Obx(
                () => Text(
                  "총 ${clubController.clubList.length}개의 동아리&소모임이 있습니다.",
                  style: const TextStyle(
                    fontSize: 9.0,
                    color: Color(0xff838383),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Expanded(flex: 3, child: clubList()),
          ],
        ),
      ),
    );
  }

  Widget clubList() {
    clubController.fetchClubList();

    return Obx(
      () {
        final postList = clubController.clubList;
        if (postList.isEmpty) {
          return Center(
            child: Text(
              "게시물이 없어요!",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: AppTheme.mainPageTextColor,
              ),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: postList.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () {
                    Get.to(() => ClubBoardDetailPage(pId: postList[index].pId));
                  },
                  child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                      child: Column(children: [
                        Row(children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppTheme.mainTextColor,
                                image: const DecorationImage(
                                    image: AssetImage(
                                        'assets/images/sunset.jpg'))),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                postList[index].title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 9.0,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.mainPageHeadlineColor),
                              ),
                              Text(
                                postList[index].title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.clubPageTitleColor),
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              SizedBox(
                                  width: 169.0,
                                  height: 33.0,
                                  child: Text(
                                    postList[index].content,
                                    maxLines: 3,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        fontSize: 9.0,
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.clubPageTitleColor),
                                  )),
                            ],
                          )
                        ]),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Divider(thickness: 1.0, color: AppTheme.dividerColor),
                      ])));
            },
          );
        }
      },
    );
  }
}
