import 'package:flutter/material.dart';
import 'package:hae_mo/common/color.dart';

class CustomThemes {
  static final ThemeData mainTheme = ThemeData(
      primaryColor: appTheme.mainColor,
      buttonTheme: const ButtonThemeData(),
      textTheme: TextTheme(
          headlineLarge: TextStyle(
              color: appTheme.mainPageHeadlineColor,
              fontWeight: FontWeight.bold,
              fontSize: 20),
          headlineMedium: TextStyle(
              color: appTheme.postingPageHeadlineColor,
              fontWeight: FontWeight.bold,
              fontSize: 20),
          bodyLarge: TextStyle(color: appTheme.mainPageTextColor, fontSize: 15),
          bodyMedium:
              TextStyle(color: appTheme.mainPageTextColor, fontSize: 12),
          bodySmall:
              TextStyle(color: appTheme.mainPageSubTextColor, fontSize: 12)),
      dividerColor: appTheme.dividerColor,
      indicatorColor: appTheme.mainPageBottomNavItemColor);

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
