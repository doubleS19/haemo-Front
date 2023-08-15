import 'package:flutter/material.dart';
import 'package:hae_mo/common/color.dart';

class CustomThemes {
  static String myFont = 'SCDream';
  static var hotPlaceSubTitleTextStyle = TextStyle(
    color: AppTheme.hotPlacePageSubTitleColor,
    fontFamily: myFont,
    fontSize: 14,
  );
  static var hotPlacePopularPostTitleTextStyle = TextStyle(
      color: AppTheme.postingPageHeadlineColor,
      fontFamily: myFont,
      fontSize: 15,
      fontWeight: FontWeight.bold);
  static var hotPlacePopularPostSubtitleTextStyle = TextStyle(
      color: AppTheme.postingPageHeadlineColor,
      fontFamily: myFont,
      fontSize: 11);
  static var hotPlacePostTitleTextStyle = TextStyle(
      color: AppTheme.postingPageHeadlineColor,
      fontFamily: myFont,
      fontSize: 13);

  static var hotPlaceBoardTitleTextStyle = TextStyle(
    fontSize: 20.0,
    color: AppTheme.mainTextColor,
    fontWeight: FontWeight.w500
  );
  static final ThemeData mainTheme = ThemeData(
      fontFamily: 'SCDream',
      primaryColor: AppTheme.mainColor,
      buttonTheme: const ButtonThemeData(),
      iconTheme: IconThemeData(color: AppTheme.postingPageHeadlineColor),
      textTheme: TextTheme(
          headlineLarge: TextStyle(
              color: AppTheme.mainPageHeadlineColor,
              fontWeight: FontWeight.bold,
              fontSize: 20),
          headlineMedium: TextStyle(
              color: AppTheme.postingPageHeadlineColor,
              fontWeight: FontWeight.bold,
              fontSize: 18),
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

  static final ThemeData dartTheme = ThemeData();

  static final ThemeData pinkTheme = ThemeData();
}

/*
Widget a() {
  return Scaffold(
      body: Center(
          child: Column(children: [
    Builder(builder: (context) {
      return Text(
        '내 동네 설정하고 시작하기',
        style: Theme.of(context).textTheme.button,
      );
    })
  ])));
}
*/
