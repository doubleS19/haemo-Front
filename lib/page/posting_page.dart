import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hae_mo/Page/my_page.dart';
import 'package:hae_mo/controller/posting_controller.dart';
import 'package:hae_mo/service/db_service.dart';

import '../model/post_model.dart';
import 'home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '헤쳐모여 TUK',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PostingPage(),
    );
  }
}

class PostingPage extends StatefulWidget {
  const PostingPage({super.key});

  @override
  State<PostingPage> createState() => _PostingPageState();
}

class _PostingPageState extends State<PostingPage> {
  final _headCountList = ["인원 선택", "1명", "2명", "3명", "4명", "5명 이상"];
  var _selectedHeadCount = "인원 선택";

  final _categoryList = ["카테고리 선택", "술", "미팅", "밥"];
  var _selectedCategory = "카테고리 선택";

  final TextEditingController _textController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _personController = TextEditingController();

  final BoardRegisterController _boradRegisterController =
      Get.put(BoardRegisterController());

  late BoardRegisterState _boardRegisterState;
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<FormState>();
  final _headKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _boardRegisterState = _boradRegisterController.boardRegisterState;
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: const Align(
              alignment: Alignment.centerLeft,
              child: Text("헤쳐모여 TUK",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.w800))),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: Container(
            margin: const EdgeInsets.all(20.0),
            child: GetBuilder<BoardRegisterController>(
              builder: (_boardRegisterController) {
                return Column(
                  children: [
                    Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _textController,
                          decoration: const InputDecoration(
                            labelText: 'Title',
                            hintText: '게시물 제목',
                            labelStyle: TextStyle(color: Colors.blueGrey),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.blueGrey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.blueGrey),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              _boardRegisterState = BoardRegisterState.empty;
                            }
                            _boardRegisterController.checkEssentialInfo(
                                _personController.text,
                                _textController.text,
                                _contentController.text,
                                _selectedCategory);
                          },
                        )),
                    const SizedBox(height: 30),
                    TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              backgroundColor:
                                  const Color.fromRGBO(22, 22, 22, 1),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              builder: (BuildContext context) {
                                return SizedBox(
                                  height: 200,
                                  child: selectDate(),
                                );
                              });
                        },
                        child: const Text("날짜 선택")),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              child: SizedBox(
                                  width: 30,
                                  child: Form(
                                    key: _headKey,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: _personController,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp('[0-9]'))
                                      ],
                                      decoration: const InputDecoration(
                                        labelText: '인원 수',
                                        hintText: '인원',
                                        labelStyle:
                                            TextStyle(color: Colors.blueGrey),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.blueGrey),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.blueGrey),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          _boardRegisterState =
                                              BoardRegisterState.empty;
                                        }
                                      },
                                    ),
                                  ))),
                          DropdownButton(
                            value: _selectedCategory,
                            items: _categoryList.map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedCategory = value!;
                              });
                            },
                          ),
                        ]),
                    Container(
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
                                _contentController.text = value;
                                _boardRegisterController.checkEssentialInfo(
                                    _selectedHeadCount,
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
                                  _selectedCategory);
                              Get.to(const HomePage());
                            },
                            child: const Text("등록"),
                          ))
                    ]
                  ],
                );
              },
            )));
  }

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
}
