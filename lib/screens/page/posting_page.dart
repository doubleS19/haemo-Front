import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hae_mo/controller/posting_controller.dart';
import '../../model/post_type_model.dart';
import '../components/customAppBar.dart';
import '../components/customTextField.dart';

class PostingPage extends StatefulWidget {
  const PostingPage({super.key, required this.postType});

  final PostType postType;

  @override
  State<PostingPage> createState() => _PostingPageState();
}

class _PostingPageState extends State<PostingPage> {
  final _selectedHeadCount = "인원 선택";
  final _selectedCategory = "카테고리 선택";

  final TextEditingController _textController = TextEditingController();

  final BoardRegisterController _boradRegisterController =
      Get.put(BoardRegisterController());

  @override
  Widget build(BuildContext context) {
    Post post = Post.fromType(widget.postType);

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child:
                Builder(builder: (context) => customAppbar(post.appBarText))),
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Flexible(
                  flex: 1,
                  child: ListView.builder(
                      itemCount:
                          min(post.title.length, post.description.length),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 17),
                            child: Row(children: [
                              Flexible(
                                  flex: 2,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(post.title[index],
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall),
                                    ],
                                  )),
                              Flexible(
                                flex: 8,
                                child: postingPageTitleTextField(
                                    post.description[index],
                                    _textController,
                                    context),
                              )
                            ]));
                      }))
              //for (int i = 0; i < min(post.title.length, post.description.length); i++)

/*                  Container(
                      height: 300,
                      width: 500,
                      child: Row(

                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            selectDropdownButton('headCount'),
                            selectDropdownButton('category')
                          ])
                  ),*/
            ],
          ),
        ));
  }
}

/*                    Container(
                        height: 370,
                        margin: const EdgeInsets.only(top: 20.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17),
                            color: const Color.fromARGB(212, 236, 236, 236)),
                        child: Form(
                            key: _key,
                            child: TextFormField(
                              controller: _contentController,
                              cursorColor: Colors.white,
                              keyboardType: TextInputType.multiline,
                              maxLines: 18,
                              maxLength: 300,
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                              onChanged: (value) {
                                _boardRegisterController.checkEssentialInfo(
                                    _personController.text,
                                    _textController.text,
                                    _contentController.text,
                                    _selectedCategory);
                              },
                              decoration: InputDecoration(
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide.none),
                                contentPadding: const EdgeInsets.all(16),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusColor: Colors.transparent,
                                hintText: "게시물 내용을 작성해주세요.",
                                hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 29, 29, 29),
                                  fontSize: 14.0,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  _boardRegisterState =
                                      BoardRegisterState.empty;
                                }
                                _boardRegisterController.checkEssentialInfo(
                                    _personController.text,
                                    _textController.text,
                                    _contentController.text,
                                    _selectedCategory);
                                return null;
                              },
                            ))),
                    const SizedBox(height: 60),
                    if (_boardRegisterState == BoardRegisterState.empty ||
                        _contentController.text.isEmpty) ...[
                      Container(
                          height: 45.0,
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueGrey),
                            onPressed: null,
                            child: const Text("등록"),
                          ))
                    ] else ...[
                      Container(
                          height: 45.0,
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            onPressed: () {
                              _boardRegisterController.checkEssentialInfo(
                                  _personController.text,
                                  _textController.text,
                                  _contentController.text,
                                  _selectedCategory);
                              _boradRegisterController.saveBoard(
                                  int.parse(_personController.text),
                                  _textController.text,
                                  _contentController.text,
                                  _selectedCategory,
                                  1);
                              Get.to(() => const HomePage());
                            },
                            child: const Text("등록"),
                          ))
                    ]*/

Widget selectDate() {
  DateTime selectDate = DateTime.now();
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              CupertinoIcons.back,
              color: Colors.white,
              size: 26,
            ),
          ),
          IconButton(
              onPressed: () {
                selectDate = DateTime.now();
                Get.back();
              },
              icon: const Icon(
                CupertinoIcons.back,
                color: Colors.white,
                size: 26,
              )),
        ],
      ),
      const Divider(
        height: 1,
        color: Colors.blueGrey,
      ),
      const SizedBox(
        height: 10,
      ),
      SizedBox(
        height: 80,
        child: CupertinoTheme(
            data: const CupertinoThemeData(
              textTheme: CupertinoTextThemeData(
                dateTimePickerTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            child: CupertinoDatePicker(
              backgroundColor: const Color(0xffffffff),
              initialDateTime: selectDate,
              maximumYear: DateTime.now().year + 1,
              maximumDate: DateTime.now(),
              minimumYear: DateTime.now().year,
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (dateTime) {
                selectDate = dateTime;
              },
            )),
      )
    ],
  );
}
