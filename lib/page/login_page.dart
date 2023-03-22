

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
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


  LoginController _loginController = Get.put(LoginController());


  @override
  void initState() {
    super.initState();

    // 될까?
    _loginController.getSecureStorageInfo().then((_) => {});
  }


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
                child: TextField(
                  decoration: const InputDecoration(
                      labelText: 'ID'
                  ),
                  onChanged: (_){

                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  
                  decoration: const InputDecoration(
                      labelText: 'PW'
                  ),
                  onChanged: (_){

                  },
                ),
              ),
              OutlinedButton(onPressed: (){
                if(true){ //  로그인이 성공하고 secureStorage에 저장되어 있다면 바로 Home으로 이동
                  print('로그인 성공');
                  Get.offAll(HomePage());
                } else if(true){  //  로그인이 성공하고 secureStorage에 저장되어 있지 않다면(최초로그인)
                  print('최초 로그인 성공');
                }  else{  // 로그인 실패
                  print('로그인 실패');
                }
              }, child: const Text('Login'))
            ],
          )
      )
    );
  }
}
