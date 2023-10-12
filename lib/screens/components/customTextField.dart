import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hae_mo/common/color.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../controller/posting_controller.dart';
import 'customButton.dart';
import 'customDialog.dart';

Widget postingPageTitleTextField(
    String hintText, TextEditingController textEdController, dynamic context) {
  return TextFormField(
    enabled: true,
    decoration: InputDecoration(
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey)
      ),
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodySmall,
        isDense: true),
    controller: textEdController,
  );
}

Widget hashTagTextField(TextfieldTagsController controller) {

  return Container(
      alignment: Alignment.center,
      child: TextFieldTags(
        textfieldTagsController: controller,
        initialTags: const [],
        textSeparators: const [' ', ','],
        letterCase: LetterCase.normal,
        validator: (String tag) {
          if (controller.getTags == null) {
            return null;
          } else if (controller.getTags!.contains(tag)) {
            return '이미 존재하는 태그입니다';
          }
          return null;
        },
        inputfieldBuilder: (context, tec, fn, error, onChanged, onSubmitted) {
          return ((context, sc, tags, onTagDelete) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: tec,
                focusNode: fn,

                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)
                  ),
                  hintText: tags.isNotEmpty ? '' : "#해시태그를 입력해주세요",
                  hintStyle: TextStyle(
                      fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
                      fontFamily:
                          Theme.of(context).textTheme.bodySmall?.fontFamily,
                      color: AppTheme.postingPageDetailHintTextColor),
                  errorText: error,
                  prefixIconConstraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.74),
                  prefixIcon: tags.isNotEmpty
                      ? SingleChildScrollView(
                          controller: sc,
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children: tags.map((String tag) {
                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Theme.of(context).primaryColor,),
                                borderRadius: const BorderRadius.all(Radius.circular(10.0),),
                                color: Colors.white,
                              ),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    child: Text(
                                      '#$tag',
                                      style:
                                          TextStyle(color: AppTheme.mainColor),
                                    ),
                                    onTap: () {
                                      print("$tag selected");
                                    },
                                  ),
                                  const SizedBox(width: 4.0),
                                  InkWell(
                                    child: Icon(
                                      Icons.cancel,
                                      size: 14.0,
                                      color: AppTheme.mainColor,
                                    ),
                                    onTap: () {
                                      onTagDelete(tag);
                                    },
                                  )
                                ],
                              ),
                            );
                          }).toList()),
                        )
                      : null,
                ),
                onChanged: onChanged,
                //onSubmitted: onSubmitted,
              ),
            );
          });
        },
      ));
}

Widget postingPageDetailTextField(
    String hintText, TextEditingController textEdController, dynamic context) {
  ScrollController scrollController = ScrollController();

  return Container(
      padding: const EdgeInsets.all(30),
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppTheme.postingPageDetailTextFieldColor,
      ),
      child: Scrollbar(
          controller: scrollController,
          child: TextFormField(
          cursorColor: AppTheme.mainPageTextColor,
          maxLines: 20,
          maxLength: 500,
          keyboardType: TextInputType.multiline,
          controller: textEdController,
          decoration: InputDecoration(
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              border: InputBorder.none,
              //filled: true,
              //fillColor: AppTheme.postingPageDetailTextFieldColor,
              hintText: hintText,
              hintStyle: TextStyle(
                  fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
                  fontFamily: Theme.of(context).textTheme.bodySmall?.fontFamily,
                  color: AppTheme.postingPageDetailHintTextColor)),
        )
      ));
}

Widget iconTextField(BuildContext context, String hintText, void Function() onPressed, String? value){
  return TextField(
    readOnly: true, // 값을 변경하지 못하게 설정
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: Theme.of(context).textTheme.bodySmall,
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      suffixIcon: IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
      ),
    ),
    controller: TextEditingController(
      text: value
    ),
  );
}


Widget chatTextField(
    TextEditingController textEditingController,
    Function onSubmit
    ) {
  return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    Expanded(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            height: 50,
            decoration: BoxDecoration(
              color: AppTheme.chatTextFieldBackgroundColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Expanded(
                child: TextFormField(
                  /// https://dalgoodori.tistory.com/60
                  controller: textEditingController,
                  maxLines: 1,
                  keyboardType: TextInputType.multiline,
                  cursorColor: AppTheme.mainColor,
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  )
                )))),
    const SizedBox(width: 8),
    chatIconButton(const Icon(FontAwesomeIcons.gear), onSubmit)
  ]);
}