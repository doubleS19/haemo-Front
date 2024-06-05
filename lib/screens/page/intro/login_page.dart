import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hae_mo/controller/login_controller.dart';
import 'package:hae_mo/screens/page/home_page.dart';
import 'package:hae_mo/screens/page/intro/register_page.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
// final LoginController _loginController = Get.put(LoginController());
// late LoginState _loginState;
// TextEditingController idCtr = TextEditingController();
// TextEditingController passwordCtr = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
// return GetMaterialApp(
//     title: '헤쳐모여 TUK',
//     theme: ThemeData(
//       primarySwatch: Colors.blue,
//     ),
//         home: Container(
//             child: Column(
//           children: [
// Padding(
//   padding: const EdgeInsets.all(20.0),
//   child: TextFormField(
//     controller: idCtr,
//     validator: (value) {
//       return (value == null || value.isEmpty)
//           ? 'Please Enter Email'
//           : null;
//     },
//     decoration: const InputDecoration(labelText: 'ID'),
//   ),
// ),
// Padding(
//   padding: const EdgeInsets.all(20.0),
//   child: TextFormField(
//     validator: (value) {
//       return (value == null || value.isEmpty)
//           ? 'Please Enter Password'
//           : null;
//     },
//     controller: passwordCtr,
//     decoration: const InputDecoration(labelText: 'PW'),
//   ),
// ),
// OutlinedButton(
//     onPressed: () async {
//       bool loginSuccess = await _loginController.login(
//           idCtr.text, passwordCtr.text);
//       if (loginSuccess) {
//         _loginController.checkUserExist(int.parse(idCtr.text));
//       }
//       // await _loginController.login(idCtr.text, passwordCtr.text);
//     },
//     child: const Text('Login')),
//             // Switch(
//             //     value: _loginController.autoLogin,
//             //     onChanged: (value) {
//             //       _loginController.setAutoLogin();
//             //     })
//           ],
//         )));
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }
// }

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hae_mo/common/color.dart';
import 'package:hae_mo/common/user_image.dart';
import 'package:hae_mo/service/db_service.dart';
import 'package:hae_mo/utils/user_image.dart';
import '../../../controller/user_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController _loginController = Get.put(LoginController());
  late LoginState _loginState;
  TextEditingController idCtr = TextEditingController();
  TextEditingController passwordCtr = TextEditingController();

  DBService db = DBService();

  @override
  Widget build(BuildContext context) {
    _loginState = _loginController.loginState;

    return Scaffold(
      appBar: null,
      body: GetBuilder<LoginController>(
        builder: (_loginController) {
          return Column(children: [
            Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                          image: const AssetImage("assets/icons/wont_icon.png"),
                          color: AppTheme.mainColor),
                      const SizedBox(height: 10.0),
                      Image(
                          image: const AssetImage("assets/icons/wont.png"),
                          color: AppTheme.mainColor)
                    ],
                  ),
                )),
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
                  bool loginSuccess = await _loginController.login(
                      idCtr.text, passwordCtr.text);
                  if (loginSuccess) {
                    _loginController.checkUserExist(int.parse(idCtr.text));
                  }
                  // await _loginController.login(idCtr.text, passwordCtr.text);
                },
                child: const Text('Login')),
          ]);
        },
      ),
    );
  }
}
