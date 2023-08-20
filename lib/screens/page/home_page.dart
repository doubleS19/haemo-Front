import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:hae_mo/common/color.dart';
import 'package:hae_mo/controller/club_page_controller.dart';
import 'package:hae_mo/controller/hotplace_page_controller.dart';
import 'package:hae_mo/model/post_type.dart';
import 'package:hae_mo/model/user_response_model.dart';
import 'package:hae_mo/screens/page/posting_page.dart';
import '../../controller/meeting_page_controller.dart';
import '../../service/db_service.dart';
import '../../utils/shared_preference.dart';
import 'club_page.dart';
import 'hot_place_page.dart';
import 'meeting_page.dart';
import 'setting/my_page.dart';

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
  Widget build(BuildContext context) {
    Get.put(MeetingPageController());
    Get.put(ClubPageController());
    Get.put(HotPlacePageController());
    DBService db = DBService();
    return FutureBuilder(
        future: db
            .getUserByNickname(PreferenceUtil.getString("nickname").toString()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final UserResponse user = snapshot.data as UserResponse;
            PreferenceUtil.setInt("uId", user.uId);
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
                              icon: Image.asset(
                                  "assets/icons/postingpage_bottomnav_icon.png"),
                              label: "",
                              activeIcon: Image.asset(
                                  "assets/icons/postingpage_bottomnav_icon.png",
                                  color: AppTheme.mainColor)),
                          BottomNavigationBarItem(
                              icon: Image.asset(
                                  "assets/icons/clubpage_bottomnav_icon.png"),
                              label: "",
                              activeIcon: Image.asset(
                                  "assets/icons/clubpage_bottomnav_icon.png",
                                  color: AppTheme.mainColor)),
                          BottomNavigationBarItem(
                              icon: Container(
                                  width: 30,
                                  height: 30,
                                  child: Image.asset(
                                      "assets/icons/hotplace_bottomnav_icon.png")),
                              label: "",
                              activeIcon: Container(
                                  width: 30,
                                  height: 30,
                                  child: Image.asset(
                                      "assets/icons/hotplace_bottomnav_icon.png",
                                      color: AppTheme.mainColor))),
                          BottomNavigationBarItem(
                              icon: Container(
                                width: 35.0,
                                height: 35.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppTheme.mainColor,
                                    width: 0.8,
                                  ),
                                  color: Colors.transparent,
                                  image: const DecorationImage(
                                    ///임시
                                    image:
                                        AssetImage('assets/user/user_cat.png'),
                                  ),
                                ),
                              ),
                              label: ""),
                        ],
                        currentIndex: _selectedIndex,
                        unselectedItemColor: const Color(0xffadadad),
                        selectedItemColor: AppTheme.mainColor,
                        onTap: _onItemTapped,
                      )),
                ),
                floatingActionButton:
                    _selectedIndex != 3 ? floatingButton() : null);
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget? floatingButton() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.add_event,
      visible: true,
      curve: Curves.bounceIn,
      foregroundColor: Colors.white,
      backgroundColor: AppTheme.mainColor,
      children: [
        SpeedDialChild(
          label: "핫플 글쓰기",
          labelStyle: const TextStyle(
              fontWeight: FontWeight.w500, color: Colors.white, fontSize: 13.0),
          labelBackgroundColor: AppTheme.mainColor,
          onTap: () {
            PreferenceUtil.remove("id");
            Get.to(() => const PostingPage(postType: PostType.hotPlace));
          },
        ),
        SpeedDialChild(
          label: "소모임 글쓰기",
          labelStyle: const TextStyle(
              fontWeight: FontWeight.w500, color: Colors.white, fontSize: 13.0),
          labelBackgroundColor: AppTheme.mainColor,
          onTap: () {
            Get.to(() => const PostingPage(postType: PostType.club));
          },
        ),
        SpeedDialChild(
          label: "새 글쓰기",
          labelStyle: const TextStyle(
              fontWeight: FontWeight.w500, color: Colors.white, fontSize: 13.0),
          labelBackgroundColor: AppTheme.mainColor,
          onTap: () {
            Get.to(() => const PostingPage(postType: PostType.meeting));
          },
        ),
      ],
    );
  }
}
