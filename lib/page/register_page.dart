import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/route_manager.dart';
import 'package:hae_mo/Page/home_page.dart';

import '../controller/user_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '헤쳐모여 TUK',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _majorList = ["학과 선택", "컴퓨터공학과", "소프트웨어공학과", "인공지능학과"];
  var _selectedMajor = "학과 선택";

  final _genderList = ["남자", "여자"];
  var _selectedGender = "남자";

  final TextEditingController _textController = TextEditingController();

  final UserController _userController = Get.put(UserController());
  final RegisterState _registerState = RegisterState.Fail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          elevation: 0.0,
          automaticallyImplyLeading: true,
        ),
        body: Container(
          margin: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _textController,
                decoration: const InputDecoration(
                  labelText: 'Nickname',
                  hintText: '닉네임을 입력하세요.',
                  labelStyle: TextStyle(color: Colors.blueGrey),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 1, color: Colors.blueGrey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 1, color: Colors.blueGrey),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DropdownButton(
                          value: _selectedMajor,
                          items: _majorList.map((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            _userController.CheckUserInfo(_textController.text,
                                _selectedMajor, _selectedGender);
                            setState(() {
                              _selectedMajor = value!;
                            });
                          },
                        ),
                        DropdownButton(
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
                            _userController.CheckUserInfo(_textController.text,
                                _selectedMajor, _selectedGender);
                          },
                        ),
                      ])),
              const SizedBox(height: 60),
              if (_registerState == RegisterState.Empty) ...[
                SizedBox(
                    height: 45.0,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey),
                      onPressed: null,
                      child: const Text("가입"),
                    ))
              ] else ...[
                SizedBox(
                    height: 45.0,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(const HomePage());
                      },
                      child: const Text("가입"),
                    ))
              ]
            ],
          ),
        ));
  }
}