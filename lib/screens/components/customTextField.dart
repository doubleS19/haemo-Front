

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hae_mo/common/color.dart';




Widget postingPageTitleTextField(
    String hintText, TextEditingController textEdController, dynamic context) {
  return TextFormField(
    enabled: true,
    decoration: InputDecoration(hintText: hintText, hintStyle: Theme.of(context).textTheme.bodySmall, isDense: true ),
    controller: textEdController,
  );
}

Widget postingPageDetailTextField(String hintText, TextEditingController textEdController, dynamic context){
  return Container(
      padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
      alignment: Alignment.center,
      //color: Theme.of(context).cardColor,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),       color: Theme.of(context).cardColor,
      ),
    child: TextFormField(
      cursorColor: AppTheme.mainPageTextColor,
      minLines: 6,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      controller: textEdController,
      decoration: InputDecoration(
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        border: InputBorder.none,
      ),
    )
  );
}