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

  static void getThemeType(){
    var themeColor = PreferenceUtil.getInt("colorTheme");

    themeType.value = (themeColor == null ? ThemeType.Blue : colorTheme[themeColor])!;
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

  static var lightGreenColor = const Color(0xFFAAD200);
  static var blueColor = const Color(0xFF82C0EA);
  static var pinkColor = const Color(0xFFFF9B9B);
  static var beigeColor = const Color(0xFFCFB67B);
  static var dividerColor = const Color(0xFFBBBBBB);
  static var mainTextColor = const Color(0xFF393939);
  static var mainAppBarColor = const Color(0xFF595959);

  /// 회원 가입 페이지
  static var registerPageHintColor = const Color(0xFF818181);
  static var registerPageFormColor = const Color(0xFFE3E3E3);

  /// 메인 게시물 페이지
  static var mainPageHeadlineColor = const Color(0XFF656565);
  static var mainPageTextColor = const Color(0xFF595959);
  static var mainPageSubTextColor = const Color(0xFF999999);
  static var mainPageBlurColor = const Color(0xFF00B2DB);
  static var mainPageBottomNavItemColor = const Color(0xFFADADAD);
  static var mainPagePersonColor = const Color(0xff3AC7E7);

  /// 소모임 게시물 페이지
  static var clubPageTitleColor = const Color(0xFF353535);

  /// 포스팅 게시물 페이지
  static var postingPageHeadlineColor = const Color(0xFFFFFFFF);
  static var postingPageDetailTextFieldColor = const Color(0xFFF5F5F5);
  static var postingPageDetailHintTextColor = const Color(0xFFB6B6B6);

  /// 채팅 페이지
  static var borderColor = const Color(0xFFD9D9D9);
  static var buttonColor = const Color(0xFFFFFFFF);
  static var receiverText = const Color(0xFFDEDEDE);
  static var senderText = const Color(0xFFC6EFF9);

  /// 핫플 페이지
  static var hotPlacePageSubTitleColor = const Color(0xFF414141);

  /// 설정 페이지
  static var settingPageMenuTextColor = const Color(0xFF7F7E7E);
  static var settingPageMenuListTextColor = const Color(0xFF515151);
  static var settingPageDividerColor = const Color(0xFFF4F4F4);
  static var settingPageAlarmBoxColor =
      const Color(0xFFF8FFDC).withOpacity(0.62);

  /// 신고 페이지
  static var reportingPageTextColor = const Color(0xff686868);
}
