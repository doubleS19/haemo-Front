import 'dart:ui';

import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../utils/shared_preference.dart';

enum ThemeType { Pink, Blue, Beige, LightGreen }

Map<int, ThemeType> colorTheme = {
  0: ThemeType.Blue,
  1: ThemeType.Beige,
  2: ThemeType.Pink,
  3: ThemeType.LightGreen
};

class AppTheme {
  static Rx<ThemeType> themeType = ThemeType.Blue.obs;

  static void getThemeType() {
    var themeColor = PreferenceUtil.getInt("colorTheme");

    themeType.value =
        (themeColor == null ? ThemeType.Blue : colorTheme[themeColor])!;
  }

  static void changeThemeType(ThemeType newThemeType) {
    themeType.value = newThemeType;
  }

  static Color get mainColor {
    switch (themeType.value) {
      case ThemeType.Pink:
        return pinkColor;
      case ThemeType.Blue:
        return blueColor;
      case ThemeType.Beige:
        return beigeColor;
      case ThemeType.LightGreen:
        return lightGreenColor;
      default:
        return blueColor; // Default to blue if themeType is not recognized
    }
  }

  static const Color lightGreenColor = Color(0xFFAAD200);
  static const Color blueColor = Color(0xFF82C0EA);
  static const Color pinkColor = Color(0xFFFF9B9B);
  static const Color beigeColor = Color(0xFFCFB67B);
  static const Color dividerColor = Color(0xFFBBBBBB);
  static const Color mainTextColor = Color(0xFF393939);
  static const Color mainAppBarColor = Color(0xFF595959);

  /// 회원 가입 페이지
  static const Color registerPageHintColor = Color(0xFF818181);
  static const Color registerPageFormColor = Color(0xFFE3E3E3);

  /// 메인 게시물 페이지
  static const Color mainPageHeadlineColor = Color(0XFF656565);
  static const Color mainPageTextColor = Color(0xFF595959);
  static const Color mainPageSubTextColor = Color(0xFF999999);
  static const Color mainPageBlurColor = Color(0xFF00B2DB);
  static const Color mainPageBottomNavItemColor = Color(0xFFADADAD);
  static const Color mainPagePersonColor = Color(0xff3AC7E7);

  /// 소모임 게시물 페이지
  static const Color clubPageTitleColor = Color(0xFF353535);
  static const Color clubPageSearchBarColor = Color(0xFFEDEDED);

  /// 포스팅 게시물 페이지
  static const Color postingPageDetailTextFieldColor = Color(0xFFF5F5F5);
  static const Color postingPageDetailHintTextColor = Color(0xFFB6B6B6);

  /// 채팅 페이지
  static const Color borderColor = Color(0xFFD9D9D9);
  static const Color white = Color(0xFFFFFFFF);
  static const Color receiverText = Color(0xFFDEDEDE);
  static const Color senderText = Color(0xFFC6EFF9);

  /// 핫플 페이지
  static const Color hotPlacePageSubTitleColor = Color(0xFF414141);

  /// 설정 페이지
  static const Color settingPageMenuTextColor = Color(0xFF7F7E7E);
  static const Color settingPageMenuListTextColor = Color(0xFF515151);
  static const Color settingPageDividerColor = Color(0xFFF4F4F4);
  static Color settingPageAlarmBoxColor =
      const Color(0xFFF8FFDC).withOpacity(0.62);
  static Color contactPageListDialogTitleTextColor =
      const Color(0xFF515151).withOpacity(0.5);
  static const Color contactPageListDialogContentTextColor = Color(0xFF686868);
  static const Color noticePageIconColor = Color(0xFFC0C0C0);

  /// 신고 페이지
  static const Color reportingPageTextColor = Color(0xff686868);

  /// 커스텀 앱바
  static const Color customAppBarBackColor = Color(0xff545454);

  /// 채팅 페이지
  static const Color chatTextFieldBackgroundColor = Color(0xFFEDEDED);
  static const Color chatReceiverBackgroundColor = Color(0xFFDEDEDE);

  /// 댓글 위젯 디바이더
  static const Color commentDividerColor = Color(0xFFBBBBBB);
}
