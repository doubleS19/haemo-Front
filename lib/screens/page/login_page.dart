import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hae_mo/controller/login_controller.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

// 자동로그인 만들기

class _LoginPageState extends State<LoginPage> {
  final LoginController _loginController = Get.put(LoginController());

  TextEditingController idCtr = TextEditingController();
  TextEditingController passwordCtr = TextEditingController();
  var switchValue = false;


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: '헤쳐모여 TUK',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Container(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: idCtr,
                validator: (value) {
                  return (value == null || value.isEmpty)
                      ? 'Please Enter Email'
                      : null;
                },
                decoration: const InputDecoration(labelText: 'ID'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                validator: (value) {
                  return (value == null || value.isEmpty)
                      ? 'Please Enter Password'
                      : null;
                },
                controller: passwordCtr,
                decoration: const InputDecoration(labelText: 'PW'),
              ),
            ),
            OutlinedButton(
                onPressed: () async {
                  await _loginController.loginUser(
                      idCtr.text, passwordCtr.text);
                },
                child: const Text('Login')),
            Switch(value: _loginController.autoLogin, onChanged: (value) {
              _loginController.setAutoLogin();
            })
          ],
        )));
  }
}
