import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hae_mo/common/color.dart';
import 'package:hae_mo/controller/meeting_page_controller.dart';
import 'package:hae_mo/model/post_response_model.dart';
import 'package:hae_mo/screens/page/board_detail_page.dart';
import 'package:hae_mo/screens/page/chat_list_page.dart';
import '../../service/db_service.dart';
import '../components/customAppBar.dart';

class MeetingPage extends StatefulWidget {
  const MeetingPage({super.key});

  @override
  State<MeetingPage> createState() => _MeetingPageState();
}

class _MeetingPageState extends State<MeetingPage> {
  final MeetingPageController meetingController =
      Get.find<MeetingPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customMainAppbar("친구 구하는 페이지", "공지 24시간"),
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: Column(
          children: [
            Expanded(child: todayNotice()),
            Expanded(flex: 3, child: postList()),
          ],
        ),
      ),
    );
  }

  Widget todayNotice() {
    meetingController.fetchTodayNotice();

    return Obx(() {
      final postList = meetingController.todayNoticeList;
      if (postList.isEmpty) {
        return Center(
          child: Text(
            "아직 시간이 많이 남았네용",
            style: TextStyle(
              fontWeight: FontWeight.w300,
              color: AppTheme.mainPageTextColor,
            ),
          ),
        );
      } else {
        return Align(
          alignment: Alignment.centerLeft,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: postList.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Get.to(() => BoardDetailPage(pId: postList[index].pId));
                },
                child: Container(
                  width: 130.0,
                  height: 148.0,
                  margin: const EdgeInsets.fromLTRB(8.0, 5.0, 0.0, 15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.mainPageBlurColor.withOpacity(0.3),
                        blurRadius: 4.0,
                      ),
                    ],
                  ),
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 0.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Get.to(() => BoardDetailPage(pId: postList[index].pId));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            postList[index].title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13.5,
                              color: AppTheme.mainPageTextColor,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(
                                      Icons.local_fire_department,
                                      size: 15.0,
                                      color: Color(0xffff2e00),
                                    ),
                                    Text(
                                      "${postList[index].person}명",
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  postList[index]
                                      .deadline
                                      .replaceAll('년 ', '.')
                                      .replaceAll('월 ', '.')
                                      .replaceAll('일', ''),
                                  style: const TextStyle(
                                    fontSize: 11.2,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }
    });
  }

  Widget postList() {
    meetingController.fetchBoardList();

    return Obx(
      () {
        final postList = meetingController.postList;
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
                  Get.to(() => BoardDetailPage(pId: postList[index].pId));
                },
                child: Column(
                  children: [
                    Container(
                      height: 50.0,
                      width: double.infinity,
                      margin: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: Text(
                                    postList[index].title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: AppTheme.mainPageTextColor,
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Expanded(
                                  child: Text(
                                    "3/${postList[index].person}",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: AppTheme.mainPagePersonColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 13.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${postList[index].person}명",
                                  style: const TextStyle(
                                    color: Color(0xff999999),
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Text(
                                  postList[index].deadline,
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: AppTheme.mainPageTextColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(thickness: 1.0, color: AppTheme.dividerColor),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
