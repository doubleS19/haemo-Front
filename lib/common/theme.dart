import 'package:flutter/material.dart';
import 'package:haemo/common/color.dart';

class CustomThemes {
  static String myFont = 'SCDream';

  /// hotPlacePage
  static var hotPlaceSubTitleTextStyle = TextStyle(
    color: AppTheme.hotPlacePageSubTitleColor,
    fontFamily: myFont,
    fontSize: 14,
  );
  static var hotPlacePopularPostTitleTextStyle = TextStyle(
      color: AppTheme.white,
      fontFamily: myFont,
      fontSize: 15,
      fontWeight: FontWeight.bold);
  static var hotPlacePopularPostSubtitleTextStyle =
      TextStyle(color: AppTheme.white, fontFamily: myFont, fontSize: 11);
  static var hotPlacePostTitleTextStyle =
      TextStyle(color: AppTheme.white, fontFamily: myFont, fontSize: 13);

  static var hotPlaceBoardTitleTextStyle = TextStyle(
      fontSize: 20.0,
      color: AppTheme.mainTextColor,
      fontWeight: FontWeight.w500);

  static var postingPageTextfieldTypeTitleTextSTyle =
      const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500);

  /// settingPage
  static var settingPageMenuTextStyle = TextStyle(
      fontSize: 14.0,
      color: AppTheme.settingPageMenuTextColor,
      fontWeight: FontWeight.w500);
  static var settingPageMenuListTextStyle = TextStyle(
      fontSize: 16.0,
      color: AppTheme.settingPageMenuListTextColor,
      fontWeight: FontWeight.w300);
  static var noticePageMenuListTextStyle = TextStyle(
      fontSize: 16.0,
      color: AppTheme.settingPageMenuListTextColor,
      fontWeight: FontWeight.w400);
  static var noticePageDateTextStyle =
      TextStyle(fontSize: 12.0, color: AppTheme.noticePageIconColor);
  static var noticeDetailPageTitleTextStyle = TextStyle(
      fontSize: 17.0, color: AppTheme.mainColor, fontWeight: FontWeight.bold);

  /// 왜 폰트 크기 적용이 안 될꺼?
  static var noticeDetailPageDateTextStyle =
      TextStyle(fontSize: 14.0, color: AppTheme.noticePageIconColor);
  static var noticeDetailPageContentTextStyle = noticePageMenuListTextStyle;

  /// deleteAccountPage
  static var deleteAccountPageTitleTextStyle = TextStyle(
      fontSize: 18.0, color: AppTheme.mainColor, fontWeight: FontWeight.bold);
  static var deleteAccountPageContentTextStyle =
      const TextStyle(fontSize: 13.0, fontWeight: FontWeight.w300);
  static var deleteAccountPageButtonTextStyle = const TextStyle(
      color: Color(0XFFFFFFFF), fontSize: 15.0, fontWeight: FontWeight.bold);
  static var alarmBoxColor = AppTheme.settingPageAlarmBoxColor;

  /// customDialog
  static var customDialogContentTextStyle = TextStyle(
      fontSize: 16.0,
      color: AppTheme.settingPageMenuListTextColor,
      fontWeight: FontWeight.w500);
  static var customDialogConfirmButtonTextStyle = TextStyle(
      fontSize: 15.0, color: AppTheme.white, fontWeight: FontWeight.w400);
  static var customDialogCancelButtonTextStyle = const TextStyle(
      fontSize: 15.0, color: Color(0xFF969696), fontWeight: FontWeight.w300);
  static var customSelectListDialoglTitleTextStyle = TextStyle(
      fontSize: 16.0,
      color: AppTheme.contactPageListDialogTitleTextColor,
      fontWeight: FontWeight.w600);
  static var customSelectListDialoglContentTextStyle = TextStyle(
      color: AppTheme.contactPageListDialogContentTextColor,
      fontWeight: FontWeight.bold);
  static var chatListTitleTeextStyle =
      TextStyle(color: AppTheme.mainAppBarColor, fontSize: 22.0);
  static var chatRoomTitleTextStyle =
      TextStyle(color: AppTheme.mainTextColor, fontSize: 22.0);

  static final ThemeData mainTheme = ThemeData(
      fontFamily: 'SCDream',
      primaryColor: AppTheme.mainColor,
      buttonTheme: const ButtonThemeData(),
      iconTheme: IconThemeData(color: AppTheme.white),
      textTheme: TextTheme(
          headlineLarge: TextStyle(
              color: AppTheme.mainPageHeadlineColor,
              fontWeight: FontWeight.bold,
              fontSize: 20),
          headlineMedium: TextStyle(
              color: AppTheme.white, fontWeight: FontWeight.bold, fontSize: 18),
          headlineSmall: TextStyle(
              color: AppTheme.mainPageHeadlineColor,
              fontWeight: FontWeight.bold,
              fontSize: 16),
          bodyLarge: TextStyle(color: AppTheme.mainPageTextColor, fontSize: 15),
          bodyMedium:
              TextStyle(color: AppTheme.mainPageTextColor, fontSize: 14),
          bodySmall:
              TextStyle(color: AppTheme.mainPageSubTextColor, fontSize: 13)),
      dividerColor: AppTheme.dividerColor,
      indicatorColor: AppTheme.mainPageBottomNavItemColor);
}
