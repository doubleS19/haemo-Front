import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final postingTextField = [
  "제목을 입력해주세요",
  "모임에 대한 내용을 입력해주세요",
];

final clubPostingTextField = [
  "제목을 입력해주세요",
  "소모임 소개내용을 입력해주세요",
  "#해시태그를 입력해주세요",
  "소모임에 대한 내용을 입력해주세요"
];

final hotPlacePostingTextField = [
  "장소를 입력해주세요",
  "핫플에 대한 간단한 설명을 입력해주세요",
  "핫플에 대해 내용을 입력해주세요",
];

Widget registerUserInfoTextField(TextEditingController _textEdictionController){
  return SafeArea(child: Center(
    child: TextFormField(

    )
  ));
}

Widget postingPageTitleTextField(void Function()? onClick, String hintText, TextEditingController textEdController) {
  final TextEditingController _textController = TextEditingController();

  return SafeArea(child: Center(
      child: TextFormField(
        enabled: false,
        decoration: InputDecoration(
            hintText: hintText
        ),
        controller: textEdController,
      )
  ));
}

Widget postingPageDetailTextField(void Function()? onClick, String hintText, TextEditingController textEdController) {
  final TextEditingController _textController = TextEditingController();

  return SafeArea(child: Center(
      child: TextFormField(
        enabled: false,
        decoration: InputDecoration(
            hintText: hintText
        ),
        controller: textEdController,
      )
  ));
}
