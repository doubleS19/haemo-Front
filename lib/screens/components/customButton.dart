import 'package:flutter/material.dart';
import 'package:hae_mo/controller/image_controller.dart';
import 'package:hae_mo/controller/posting_controller.dart';

import '../../common/color.dart';
import '../../common/theme.dart';


/// PostingPage 등록 버튼
Widget postingButton(BuildContext context, void Function()? onPressed) {
  return Container(
    height: MediaQuery.of(context).size.height/20,
    child: ElevatedButton(onPressed: onPressed,
        style: OutlinedButton.styleFrom(backgroundColor: AppTheme.mainColor),
        child: Text("등록하기", style: TextStyle(
            fontFamily: Theme.of(context).textTheme.headlineSmall?.fontFamily,
            fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,

            color: AppTheme.postingPageHeadlineColor)))
  );
}


Widget settingPageCustomButton(String content, Function onClick){
  return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Container(
          height: 45,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              color: AppTheme.mainColor,
              borderRadius: BorderRadius.circular(50)),
          child: Center(
            child: Text(content,
                style:
                CustomThemes.deleteAccountPageButtonTextStyle),
          )),

  );
}