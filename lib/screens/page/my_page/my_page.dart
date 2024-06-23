import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haemo/common/color.dart';
import 'package:haemo/common/user_image.dart';
import 'package:haemo/screens/components/customAppBar.dart';
import 'package:haemo/screens/page/my_page/my_meeting_page.dart';
import 'package:haemo/screens/page/my_page/my_wish_club_page%20.dart';
import 'package:haemo/screens/page/my_page/my_wish_meeting_page.dart';
import 'package:haemo/screens/page/my_page/my_wish_place_page.dart';
import 'package:haemo/utils/shared_preference.dart';
import 'package:haemo/model/user_response_model.dart';
import 'package:haemo/service/db_service.dart';

import '../../Page/chat/chat_list_page.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  var myPageList = ["내가 작성한 글", "찜한 장소", "가고 싶은 모임"];
  @override
  Widget build(BuildContext context) {
    DBService db = DBService();
    return Scaffold(
        appBar: myPageAppbar("마이페이지"),
        backgroundColor: Colors.white,
        body: FutureBuilder(
            future: db.getUserByNickname(PreferenceUtil.getString("nickname")!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final UserResponse user = snapshot.data as UserResponse;
                return Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    child: Column(children: [
                      userInfo(user),
                      const SizedBox(
                        height: 30.0,
                      ),
                      const Divider(color: AppTheme.mainPageTextColor),
                      myPageColumn()
                    ]));
              } else {
                return const Center(
                    child: Text("회원 정보를 불러오는데 실패했습니다.\n다시 시도해주세요."));
              }
            }));
  }

  Widget myList() {
    return ListView.builder(
        itemCount: myPageList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {
                Get.to(() => const ChatListPage());
              },
              child: Column(children: [
                Container(
                    height: 50.0,
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(children: [
                          Text(
                            myPageList[index],
                            style: TextStyle(
                                color: AppTheme.mainPageTextColor,
                                fontSize: 13.5,
                                fontWeight: FontWeight.w600),
                          ),
                          Divider(thickness: 1.0, color: AppTheme.dividerColor)
                        ])))
              ]));
        });
  }
}

Widget myPageColumn() {
  return Column(children: [
    InkWell(
        onTap: () {
          Get.to(() => const MyMeetingPage());
        },
        child: Container(
            width: double.infinity,
            height: 44.0,
            margin: const EdgeInsets.only(left: 20.0),
            alignment: Alignment.centerLeft,
            child: Text(
              "내가 작성한 글",
              style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w300,
                  color: AppTheme.mainTextColor),
            ))),
    Divider(color: AppTheme.mainPageTextColor),
    InkWell(
        onTap: () {
          Get.to(() => const MyWishPlacePage());
        },
        child: Container(
          width: double.infinity,
          height: 44.0,
          margin: const EdgeInsets.only(left: 20.0),
          alignment: Alignment.centerLeft,
          child: Text(
            "찜한 장소",
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w300,
                color: AppTheme.mainTextColor),
          ),
        )),
    Divider(color: AppTheme.mainPageTextColor),
    InkWell(
        onTap: () {
          Get.to(const MyWishMeetingPage());
        },
        child: Container(
          width: double.infinity,
          height: 44.0,
          margin: const EdgeInsets.only(left: 20.0),
          alignment: Alignment.centerLeft,
          child: Text(
            "가고 싶은 모임",
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w300,
                color: AppTheme.mainTextColor),
          ),
        )),
    Divider(color: AppTheme.mainPageTextColor),
    InkWell(
        onTap: () {
          Get.to(const MyWishClubPage());
        },
        child: Container(
          width: double.infinity,
          height: 44.0,
          margin: const EdgeInsets.only(left: 20.0),
          alignment: Alignment.centerLeft,
          child: Text(
            "가고 싶은 소모임",
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w300,
                color: AppTheme.mainTextColor),
          ),
        ))
  ]);
}

Widget userInfo(UserResponse user) {
  return Column(
    children: [
      const Text(
        "프로필",
        style: TextStyle(
            fontSize: 20.0,
            color: Color(0xff818181),
            fontWeight: FontWeight.w700),
      ),
      const SizedBox(
        height: 10.0,
      ),
      Container(
        width: 200,
        height: 200,
        alignment: Alignment.center,
        child: Image(image: AssetImage(userProfileImage[user.userImage])),
      ),
      const SizedBox(
        height: 12.0,
      ),
      Text(
        user.major,
        style: const TextStyle(
          fontSize: 10.0,
          fontWeight: FontWeight.w300,
        ),
      ),
      const SizedBox(
        height: 10.0,
      ),
      Text(
        user.nickname,
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
        ),
      )
    ],
  );
}
