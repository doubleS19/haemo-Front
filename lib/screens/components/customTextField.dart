import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hae_mo/common/color.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../controller/posting_controller.dart';

Widget postingPageTitleTextField(
    String hintText, TextEditingController textEdController, dynamic context) {
  return TextFormField(
    enabled: true,
    decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodySmall,
        isDense: true),
    controller: textEdController,
  );
}

Widget hashTagTextField(TextfieldTagsController controller) {
  return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppTheme.postingPageDetailTextFieldColor,
      ),
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
              child: TextField(
                controller: tec,
                focusNode: fn,
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  isDense: true,
                  // border: const OutlineInputBorder(
                  //   borderSide: BorderSide(
                  //     color: Color.fromARGB(255, 74, 137, 92),
                  //     width: 3.0,
                  //   ),
                  // ),
                  // focusedBorder: const OutlineInputBorder(
                  //   borderSide: BorderSide(
                  //     color: Color.fromARGB(255, 74, 137, 92),
                  //     width: 3.0,
                  //   ),
                  // ),
                  //helperText: 'Enter language...',
                  helperStyle: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.bodySmall?.fontFamily,
                    fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
                    color: Theme.of(context).primaryColor,
                  ),
                  hintText: controller.hasTags ? '' : "#해시태그를 입력해주세요",
                  hintStyle: TextStyle(
                      fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
                      fontFamily: Theme.of(context).textTheme.bodySmall?.fontFamily,
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
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                                color: Theme.of(context).primaryColor,
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
                                          const TextStyle(color: Colors.white),
                                    ),
                                    onTap: () {
                                      print("$tag selected");
                                    },
                                  ),
                                  const SizedBox(width: 4.0),
                                  InkWell(
                                    child: const Icon(
                                      Icons.cancel,
                                      size: 14.0,
                                      color: Color.fromARGB(255, 233, 233, 233),
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
                onSubmitted: onSubmitted,
              ),
            );
          });
        },
      ));
}

Widget postingPageDetailTextField(
    String hintText, TextEditingController textEdController, dynamic context) {
  return Container(
      padding: const EdgeInsets.all(30),
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppTheme.postingPageDetailTextFieldColor,
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
            //filled: true,
            //fillColor: AppTheme.postingPageDetailTextFieldColor,
            hintText: hintText,
            hintStyle: TextStyle(
                fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
                fontFamily: Theme.of(context).textTheme.bodySmall?.fontFamily,
                color: AppTheme.postingPageDetailHintTextColor)),
      ));
}
