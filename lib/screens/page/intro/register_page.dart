import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haemo/common/color.dart';
import 'package:haemo/common/user_image.dart';
import 'package:haemo/service/db_service.dart';
import 'package:haemo/utils/user_image.dart';
import '../../../controller/user_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _majorList = ["학과 선택", "컴퓨터공학과", "소프트웨어공학과", "인공지능학과"];
  var _selectedMajor = "학과 선택";

  final _genderList = ["성별", "남자", "여자"];
  var _selectedGender = "성별";
  var _index = 0;

  final TextEditingController _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final UserController _userController = Get.put(UserController());

  late RegisterState _registerState;

  final CarouselController _carouselController = CarouselController();

  DBService db = DBService();

  @override
  Widget build(BuildContext context) {
    _registerState = _userController.registerState;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0.0,
        title: Text(
          "회원가입",
          style: TextStyle(
            color: AppTheme.mainAppBarColor,
            fontSize: 19.0,
          ),
        ),
        automaticallyImplyLeading: true,
      ),
      body: GetBuilder<UserController>(
        builder: (_userController) {
          return Column(children: [
            Divider(color: AppTheme.mainColor),
            Container(
                margin: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.only(top: 30.0),
                child: Column(children: [
                  const Image(
                    image: AssetImage("assets/icons/wont.png"),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    "프로필",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: AppTheme.registerPageHintColor,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                      height: 200.0,
                      width: double.infinity,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                _carouselController.previousPage();
                              },
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: AppTheme.mainColor,
                              ),
                            ),
                            SizedBox(
                                width: 200,
                                height: 200,
                                child: CarouselSlider.builder(
                                  carouselController: _carouselController,
                                  itemCount: userProfileImage.length,
                                  itemBuilder: (context, index, realIndex) {
                                    final path = userProfileImage[index];
                                    return imageSlider(path, index);
                                  },
                                  options: CarouselOptions(
                                    initialPage: 0,
                                    viewportFraction: 1,
                                    enlargeCenterPage: true,
                                    onPageChanged: (index, reason) =>
                                        setState(() {
                                      _index = index;
                                    }),
                                  ),
                                )),
                            IconButton(
                              onPressed: () {
                                _carouselController.nextPage();
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                color: AppTheme.mainColor,
                              ),
                            ),
                          ])),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "닉네임",
                      style: TextStyle(
                          color: AppTheme.mainTextColor,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: _textController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppTheme.registerPageFormColor,
                          hintText: '닉네임을 입력하세요.',
                          hintStyle: TextStyle(
                              color: AppTheme.registerPageHintColor,
                              fontSize: 15.0),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(
                                width: 1,
                                color: AppTheme.registerPageFormColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(
                                width: 1,
                                color: AppTheme.registerPageFormColor),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            _registerState = RegisterState.empty;
                          }
                          return null;
                        },
                      )),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "성별",
                              style: TextStyle(
                                  color: AppTheme.mainTextColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: DropdownButton(
                                value: _selectedGender,
                                items: _genderList.map((value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedGender = value!;
                                  });
                                  _userController.checkUserInfo(
                                      _textController.text,
                                      _selectedMajor,
                                      _selectedGender);
                                },
                              )),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "전공",
                              style: TextStyle(
                                  color: AppTheme.mainTextColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: DropdownButton(
                              value: _selectedMajor,
                              items: _majorList.map((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedMajor = value!;
                                });
                                _userController.checkUserInfo(
                                    _textController.text,
                                    _selectedMajor,
                                    _selectedGender);
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ])),
            const SizedBox(height: 30),
            if (_registerState == RegisterState.fail ||
                _registerState == RegisterState.empty) ...[
              Container(
                  margin: const EdgeInsets.only(right: 30, left: 30.0),
                  height: 45.0,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        backgroundColor: Colors.white),
                    onPressed: null,
                    child: const Text(
                      "등록",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w300),
                    ),
                  ))
            ] else ...[
              Container(
                  margin: const EdgeInsets.only(right: 30, left: 30.0),
                  height: 45.0,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      backgroundColor: AppTheme.mainColor,
                    ),
                    onPressed: () async {
                      bool isAvailableNickname = await _userController
                          .checkNickname(_textController.text);
                      if (isAvailableNickname) {
                        _userController.saveInfo(
                          _textController.text,
                          _selectedMajor,
                          _selectedGender,
                          _index,
                        );
                      } else {
                        showNicknameUnavailable(
                            context, "닉네임 사용 불가", "이미 사용 중인 닉네임입니다.");
                      }
                    },
                    child: const Text(
                      "등록",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w300),
                    ),
                  ))
            ]
          ]);
        },
      ),
    );
  }

  Widget imageSlider(path, index) => Container(
        width: 100,
        height: 200,
        color: Colors.transparent,
        child: Image.asset(path),
      );
}

void showNicknameUnavailable(
    BuildContext context, String title, String content) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: Container(child: Text(content)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('닫기'),
        ),
      ],
    ),
  );
}
