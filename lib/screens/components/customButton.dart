import 'package:flutter/material.dart';
import 'package:hae_mo/controller/posting_controller.dart';

import '../../common/color.dart';


/// PostingPage 사진 첨부 버튼
Widget galleryButton(int pictureNum, dynamic context) {
  return Container(
      width: 100,
      height: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        //border: Bord,
        borderRadius: BorderRadius.circular(13),
      ),
      child: OutlinedButton(
        onPressed: () {},
        onFocusChange: null,
        //style: OutlinedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
        child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(
                Icons.photo,
                color: AppTheme.postingPageDetailHintTextColor,
              ),
              Text(
                "$pictureNum/4",
                style: Theme
                    .of(context)
                    .textTheme
                    .bodySmall,
              ),
            ])),
      ));
}



/// PostingPage 등록 버튼
Widget postingButton(dynamic context, void Function()? onPressed) {
  return ElevatedButton(onPressed: onPressed,
      style: OutlinedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
      child: Text("등록하기", style: TextStyle(
        fontFamily: Theme.of(context).textTheme.headlineSmall?.fontFamily,
          fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,

          color: AppTheme.postingPageHeadlineColor)));
}