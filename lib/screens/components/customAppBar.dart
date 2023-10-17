import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hae_mo/controller/club_page_controller.dart';
import 'package:hae_mo/controller/meeting_page_controller.dart';
import 'package:hae_mo/screens/components/wishStarButton.dart';
import 'package:hae_mo/screens/page/setting/settings_page.dart';
import 'package:hae_mo/utils/shared_preference.dart';

import '../../common/color.dart';
import '../../common/theme.dart';
import '../Page/board/meeting_page.dart';
import '../Page/chat/chat_list_page.dart';
import 'customDialog.dart';

Widget customColorAppbar(BuildContext context, String appBarText) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white, // 회색
  ));

  return AppBar(
    title: Text(appBarText, style: Theme.of(context).textTheme.headlineMedium),
    centerTitle: true,
    leading: IconButton(
      onPressed: () {
        Get.back();
      },
      color: Theme.of(context).iconTheme.color,
      icon: const Icon(Icons.arrow_back_ios),
    ),
    elevation: 0.0,
    backgroundColor: AppTheme.mainColor,
  );
}

PreferredSizeWidget customMainAppbar(String appBarTitle, String subTitle) {
  return AppBar(
    backgroundColor: Colors.white,
    title: Container(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 10.0),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appBarTitle,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 17.0,
              color: AppTheme.mainPageHeadlineColor,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            subTitle,
            style: TextStyle(
              color: AppTheme.mainTextColor,
              fontSize: 10.0,
            ),
          ),
        ],
      ),
    ),
    shape: Border(
      bottom: BorderSide(
        color: AppTheme.dividerColor,
        width: 0.5,
      ),
    ),
    actions: [
      IconButton(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 10.0, right: 10.0),
          onPressed: () {
            Get.to(() => const ChatListPage());
          },
          icon: Image.asset("assets/icons/menu_icon.png",
              color: AppTheme.mainColor),
          color: AppTheme.mainColor),
    ],
    elevation: 0.0,
    automaticallyImplyLeading: false,
  );
}

AppBar backAppBar() {
  return AppBar(
    backgroundColor: Colors.white,
    leading: IconButton(
      onPressed: () {
        Get.back();
      },
      color: AppTheme.dividerColor,
      icon: const Icon(Icons.arrow_back_ios_new_sharp),
    ),
    elevation: 0.0,
    automaticallyImplyLeading: false,
    shape: Border(
      bottom: BorderSide(
        color: AppTheme.mainColor,
        width: 0.5,
      ),
    ),
  );
}

Widget customColorSettingPageAppbar(
    BuildContext context, String appBarText, Function onClickNo) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white, // 회색
  ));

  return AppBar(
    title: Text(appBarText, style: Theme.of(context).textTheme.headlineMedium),
    centerTitle: true,
    leading: IconButton(
      onPressed: () {
        restartAppDialog(
            context, "테마 설정을 위해 앱이 재시작됩니다.", "아니요", "예", onClickNo);
      },
      color: Theme.of(context).iconTheme.color,
      icon: const Icon(Icons.arrow_back),
    ),
    elevation: 0.0,
    backgroundColor: AppTheme.mainColor,
  );
}

Widget backButtonAppbar(BuildContext context, String appBarText) {
  return AppBar(
    title: Text(appBarText, style: Theme.of(context).textTheme.headlineMedium),
    centerTitle: true,
    leading: IconButton(
      onPressed: () {
        Get.back();
      },
      color: AppTheme.mainPageHeadlineColor,
      icon: const Icon(Icons.arrow_back_ios),
    ),
    shape: Border(
      bottom: BorderSide(
        color: AppTheme.mainColor,
        width: 1,
      ),
    ),
    elevation: 0.0,
    backgroundColor: AppTheme.white,
  );
}

Widget noticePageAdminAppbar(
    BuildContext context, String appBarText, Widget iconButton) {
  return AppBar(
    title: Text(appBarText, style: Theme.of(context).textTheme.headlineMedium),
    centerTitle: true,
    leading: IconButton(
      onPressed: () {
        Get.back();
      },
      color: Theme.of(context).iconTheme.color,
      icon: const Icon(Icons.arrow_back_ios),
    ),
    actions: [iconButton],
    elevation: 0.0,
    backgroundColor: AppTheme.mainColor,
  );
}

AppBar boardDetailAppbar(MeetingPageController meetingController,
    ClubPageController clubPageController, int type, int pId) {
  return AppBar(
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.black,
    elevation: 0.0,
    automaticallyImplyLeading: true,
    actions: [
      if (type == 1) ...[
        FutureBuilder<bool>(
          future: meetingController.checkIsWished(
            PreferenceUtil.getInt("uId")!,
            pId,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // 데이터가 로딩 중일 때 표시할 위젯
              return Container(); // 예시로 로딩 스피너를 사용했습니다.
            } else if (snapshot.hasError) {
              // 에러가 발생한 경우 표시할 위젯
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data == null) {
              // 데이터가 없는 경우나 null인 경우 표시할 위젯
              return Text('Data not available');
            } else {
              // 데이터가 정상적으로 로드된 경우 표시할 위젯
              final bool fillHeartColor = snapshot.data!;
              return WishStarButton(
                  fillHeart: fillHeartColor,
                  uId: PreferenceUtil.getInt("uId")!,
                  pId: pId,
                  type: type);
            }
          },
        )
      ] else ...[
        FutureBuilder<bool>(
          future: clubPageController.checkIsWished(
            PreferenceUtil.getInt("uId")!,
            pId,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // 데이터가 로딩 중일 때 표시할 위젯
              return CircularProgressIndicator(); // 예시로 로딩 스피너를 사용했습니다.
            } else if (snapshot.hasError) {
              // 에러가 발생한 경우 표시할 위젯
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data == null) {
              // 데이터가 없는 경우나 null인 경우 표시할 위젯
              return Text('Data not available');
            } else {
              // 데이터가 정상적으로 로드된 경우 표시할 위젯
              final bool fillHeartColor = snapshot.data!;
              return WishStarButton(
                  fillHeart: fillHeartColor,
                  uId: PreferenceUtil.getInt("uId")!,
                  pId: pId,
                  type: type);
            }
          },
        )
      ]
    ],
  );
}

AppBar boardWriterAppbar() {
  return AppBar(
    backgroundColor: Colors.white,
    leading: IconButton(
      onPressed: () {
        Get.back();
      },
      color: AppTheme.customAppBarBackColor,
      icon: const Icon(Icons.arrow_back_ios_new_sharp),
    ),
    elevation: 0.0,
    automaticallyImplyLeading: true,
    actions: [
      IconButton(
          icon: Image.asset("assets/icons/menu_icon.png",
              color: AppTheme.mainColor),
          color: AppTheme.mainColor,
          onPressed: () {})
    ],
  );
}

Widget chatRoomAppbar(String appBarText, BuildContext context) {
  return AppBar(
    title: Text(appBarText, style: CustomThemes.chatRoomTitleTextStyle),
    centerTitle: false,
    leading: IconButton(
      onPressed: () {
        Get.back();
      },
      color: AppTheme.mainColor,
      icon: const Icon(Icons.arrow_back_ios),
    ),
    shape: Border(
      bottom: BorderSide(
        color: AppTheme.dividerColor,
        width: 0.5,
      ),
    ),
    actions: [
      IconButton(
          icon: const Icon(Icons.menu),
          color: AppTheme.mainColor,
          onPressed: () {})
    ],
    elevation: 0.0,
    backgroundColor: AppTheme.white,
  );
}

PreferredSizeWidget myPageAppbar(String appBarTitle) {
  return AppBar(
    backgroundColor: Colors.white,
    title: Container(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 10.0),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appBarTitle,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 17.0,
              color: AppTheme.mainPageHeadlineColor,
            ),
          ),
        ],
      ),
    ),
    shape: Border(
      bottom: BorderSide(
        color: AppTheme.dividerColor,
        width: 0.5,
      ),
    ),
    actions: [
      IconButton(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 10.0, right: 10.0),
          onPressed: () {
            Get.to(() => const SettingsPage());
          },
          icon: Image.asset("assets/icons/setting_icon.png",
              color: AppTheme.mainColor),
          color: AppTheme.mainColor),
    ],
    elevation: 0.0,
    automaticallyImplyLeading: false,
  );
}
