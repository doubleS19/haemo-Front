import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hae_mo/common/color.dart';
import '../../controller/user_controller.dart';

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

  final TextEditingController _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final UserController _userController = Get.put(UserController());

  late RegisterState _registerState;

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
                  const Text(
                    "헤모 🍻",
                    style: TextStyle(fontSize: 48.0),
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
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        color: AppTheme.registerPageFormColor,
                        borderRadius: BorderRadius.circular(15.0)),
                    alignment: Alignment.center,
                  ),
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
                    onPressed: () {
                      _userController.saveInfo(_textController.text,
                          _selectedMajor, _selectedGender);
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
}
