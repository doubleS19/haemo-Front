import 'package:flutter/material.dart';
import 'package:hae_mo/controller/image_controller.dart';
import 'package:hae_mo/controller/posting_controller.dart';

import '../../common/color.dart';


/// PostingPage 등록 버튼
Widget postingButton(BuildContext context, void Function()? onPressed) {
  return ElevatedButton(onPressed: onPressed,
      style: OutlinedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
      child: Text("등록하기", style: TextStyle(
        fontFamily: Theme.of(context).textTheme.headlineSmall?.fontFamily,
          fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,

          color: AppTheme.postingPageHeadlineColor)));
}