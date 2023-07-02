

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



Widget registerUserInfoTextField(
    TextEditingController _textEdictionController) {
  return SafeArea(child: Center(child: TextFormField()));
}

Widget postingPageTitleTextField(
    String hintText, TextEditingController textEdController, dynamic context) {
  return TextFormField(
    enabled: true,
    decoration: InputDecoration(hintText: hintText, hintStyle: Theme.of(context).textTheme.bodySmall, isDense: true ),
    controller: textEdController,
  );
}

Widget postingPageDetailTextField(void Function()? onClick, String hintText,
    TextEditingController textEdController) {
  final TextEditingController _textController = TextEditingController();

  return SafeArea(
      child: Center(
          child: TextFormField(
    enabled: false,
    decoration: InputDecoration(hintText: hintText),
    controller: textEdController,
  )));
}
