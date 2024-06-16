import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haemo/common/color.dart';
import 'package:haemo/controller/board/attend_controller.dart';
import 'package:haemo/controller/meeting_page_controller.dart';
import 'package:haemo/model/post_response_model.dart';
import 'package:haemo/screens/page/board/board_detail_page.dart';
import '../../components/customAppBar.dart';
import '../../components/customIndicator.dart';

class MeetingPage extends StatefulWidget {
  const MeetingPage({super.key});

  @override
  State<MeetingPage> createState() => _MeetingPageState();
}

class _MeetingPageState extends State<MeetingPage> {
  final MeetingPageController meetingController =
      Get.find<MeetingPageController>();
  final AttendController attendController = AttendController();
  List<PostResponse> meetingList = <PostResponse>[];
  List<PostResponse> todayMeetingList = <PostResponse>[];

  @override
  void initState() {
    super.initState();
    meetingController.fetchBoardList();
    meetingController.fetchTodayNotice();
    attendController.fetchAttendeesCount();
  }

  @override
  Widget build(BuildContext context) {
    attendController.fetchAttendeesCount();
    meetingController.fetchTodayNotice();
    todayMeetingList = meetingController.todayNoticeList;
    meetingList = meetingController.postList;

    return Scaffold(
      appBar: customMainAppbar("친구 구하는 페이지", "공지 24시간"),
      body: Container(
          alignment: Alignment.center,
          color: Colors.white,
          child: todayMeetingList.isEmpty
              ? postList()
              : Column(
                  children: [
                    Expanded(child: todayNotice()),
                    Expanded(flex: 3, child: postList())
                  ],
                )),
    );
  }

  Widget todayNotice() {
    meetingController.fetchTodayNotice();

    return Obx(() {
      todayMeetingList = meetingController.todayNoticeList;
      return Align(
        alignment: Alignment.centerLeft,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: todayMeetingList.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Get.to(() => BoardDetailPage(
                    pId: todayMeetingList[index].pId,
                    type: 1,
                    meetingPost: todayMeetingList[index],
                    clubPost: null));
              },
              child: Container(
                width: 130.0,
                height: 148.0,
                margin: const EdgeInsets.fromLTRB(8.0, 5.0, 0.0, 15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.mainColor.withOpacity(0.3),
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
                      Get.to(() => BoardDetailPage(
                          pId: todayMeetingList[index].pId,
                          type: 1,
                          meetingPost: todayMeetingList[index],
                          clubPost: null));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          todayMeetingList[index].title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
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
                                    "${todayMeetingList[index].person}명",
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                todayMeetingList[index]
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
    });
  }

  Widget postList() {
    meetingController.fetchBoardList();
    attendController.fetchAttendeesCount();
    List<int> attendPerson = List.filled(10000, 0);
    return Obx(
      () {
        meetingList = meetingController.postList;
        attendPerson = attendController.attendeesCount;

        if (meetingList.isEmpty) {
          return const Center(
            child: Text(
              "게시물이 없어요!",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: AppTheme.mainPageTextColor,
              ),
            ),
          );
        } else {
          return CheckMarkIndicator(
              onClick: {
                meetingController.fetchBoardList(),
                meetingController.fetchTodayNotice()
              },
              child: ListView.builder(
                itemCount: meetingList.length,
                itemBuilder: (BuildContext context, int index) {
                  attendController.fetchAttendList(meetingList[index].pId);
                  attendPerson.length >= index
                      ? attendController.fetchAttendList(meetingList[index].pId)
                      : attendController.fetchAttendeesCount();
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => BoardDetailPage(
                          pId: meetingList[index].pId,
                          type: 1,
                          meetingPost: meetingList[index],
                          clubPost: null));
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 8,
                                      child: Text(
                                        meetingList[index].title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: AppTheme.mainPageTextColor,
                                          fontSize: 13.5,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10.0),
                                    Expanded(
                                      child: Text(
                                        "${attendPerson[index]}/${meetingList[index].person}",
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: AppTheme.mainColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 13.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${meetingList[index].person}명",
                                      style: const TextStyle(
                                        color: Color(0xff999999),
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    Text(
                                      meetingList[index].deadline,
                                      style: const TextStyle(
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
                        const Divider(
                            thickness: 1.0, color: AppTheme.dividerColor),
                      ],
                    ),
                  );
                },
              ));
        }
      },
    );
  }
}
