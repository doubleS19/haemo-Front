import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:haemo/common/color.dart';
import 'package:haemo/common/user_image.dart';
import 'package:haemo/controller/club_page_controller.dart';
import 'package:haemo/controller/hotplace_page_controller.dart';
import 'package:haemo/model/post_type.dart';
import 'package:haemo/screens/page/board/posting_page.dart';
import 'package:haemo/screens/page/setting/notice_posting_page.dart';
import '../../controller/meeting_page_controller.dart';
import '../../utils/shared_preference.dart';
import '../Page/board/club_page.dart';
import '../Page/board/hot_place_page.dart';
import '../Page/board/meeting_page.dart';
import 'my_page/my_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const MeetingPage(),
    const ClubPage(),
    const HotPlacePage(),
    const MyPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.getToken().then((token) {
      print('FCM Token: $token');
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.put(MeetingPageController());
    Get.put(ClubPageController());
    Get.put(HotPlacePageController());
    return Scaffold(
        body: SafeArea(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.only(left: 2.0, right: 2.0),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(15.0),
                  topLeft: Radius.circular(15.0)),
              boxShadow: [
                BoxShadow(
                    color: AppTheme.mainColor,
                    spreadRadius: 2.0,
                    blurRadius: 0.0)
              ]),
          child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(15.0),
                  topLeft: Radius.circular(15.0)),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Image.asset("assets/icons/meeting_bottom_icon.png",
                          color: Colors.black),
                      label: "",
                      activeIcon: Image.asset(
                          "assets/icons/meeting_bottom_icon.png",
                          color: AppTheme.mainColor)),
                  BottomNavigationBarItem(
                      icon: Image.asset("assets/icons/club_bottom_icon.png",
                          color: Colors.black),
                      label: "",
                      activeIcon: Image.asset(
                          "assets/icons/club_bottom_icon.png",
                          color: AppTheme.mainColor)),
                  BottomNavigationBarItem(
                      icon: SizedBox(
                        width: 30,
                        height: 30,
                        child: Image.asset(
                            "assets/icons/hotplace_bottom_icon.png",
                            color: Colors.black),
                      ),
                      label: "",
                      activeIcon: SizedBox(
                          width: 30,
                          height: 30,
                          child: Image.asset(
                              "assets/icons/hotplace_bottom_icon.png",
                              color: AppTheme.mainColor))),
                  BottomNavigationBarItem(
                    icon: Container(
                      width: 35.0,
                      height: 35.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black,
                          width: 0.8,
                        ),
                        color: Colors.transparent,
                        image: DecorationImage(
                          image: AssetImage(userRoundImage[
                              PreferenceUtil.getInt("userImage")!]),
                        ),
                      ),
                    ),
                    label: "",
                    activeIcon: Container(
                      width: 35.0,
                      height: 35.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppTheme.mainColor,
                          width: 0.8,
                        ),
                        color: Colors.transparent,
                        image: DecorationImage(
                          image: AssetImage(userRoundImage[
                              PreferenceUtil.getInt("userImage")!]),
                        ),
                      ),
                    ),
                  ),
                ],
                currentIndex: _selectedIndex,
                unselectedItemColor: const Color(0xffadadad),
                selectedItemColor: AppTheme.mainColor,
                onTap: _onItemTapped,
              )),
        ),
        floatingActionButton: _selectedIndex != 3 ? floatingButton() : null);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget? floatingButton() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      visible: true,
      curve: Curves.bounceIn,
      foregroundColor: Colors.white,
      backgroundColor: AppTheme.mainColor,
      children: [
        if (PreferenceUtil.getString("role") == "USER") ...[
          SpeedDialChild(
            label: "핫플 글쓰기",
            labelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 13.0),
            labelBackgroundColor: AppTheme.mainColor,
            onTap: () {
              Get.to(() => const PostingPage(postType: PostType.hotPlace));
            },
          ),
          SpeedDialChild(
            label: "소모임 글쓰기",
            labelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 13.0),
            labelBackgroundColor: AppTheme.mainColor,
            onTap: () {
              Get.to(() => const PostingPage(postType: PostType.club));
            },
          ),
          SpeedDialChild(
            label: "새 글쓰기",
            labelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 13.0),
            labelBackgroundColor: AppTheme.mainColor,
            onTap: () {
              Get.to(() => const PostingPage(postType: PostType.meeting));
            },
          ),
        ] else ...[
          SpeedDialChild(
            label: "공지 작성",
            labelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 13.0),
            labelBackgroundColor: AppTheme.mainColor,
            onTap: () {
              Get.to(() => NoticePostingPage());
            },
          ),
        ]
      ],
    );
  }
}
