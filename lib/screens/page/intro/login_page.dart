import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haemo/common/color.dart';
import 'package:haemo/common/user_image.dart';
import 'package:haemo/controller/login_controller.dart';
import 'package:haemo/screens/components/customDialog.dart';
import 'package:haemo/screens/components/customTextField.dart';
import 'package:haemo/screens/page/board/posting_page.dart';
import 'package:haemo/service/db_service.dart';
import 'package:haemo/utils/user_image.dart';
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
      backgroundColor: Colors.white,
      body: GetBuilder<LoginController>(
        builder: (_loginController) {
          return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
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
              padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
              child: columnTextField(context, 'ID', idCtr, false),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 30.0),
              child: columnTextField(context, 'P/W', passwordCtr, true),
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                height: 45.0,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      backgroundColor: AppTheme.mainColor),
                  onPressed: () async {
                    if (idCtr.text.isEmpty || passwordCtr.text.isEmpty) {
                      return showConfirmDialog(
                          context, "아이디와 비밀번호를 입력해주세요", null);
                    }
                    bool loginSuccess = await _loginController.login(
                        idCtr.text, passwordCtr.text);
                    if (loginSuccess) {
                      _loginController.checkUserExist(int.parse(idCtr.text));
                    } else {
                      return showConfirmDialog(
                          context, "로그인에 실패했습니다.\n아이디나 비밀번호를 확인해 주세요.", null);
                    }
                  },
                  child: const Text(
                    "등록",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ))
          ]);
        },
      ),
    );
  }
}
