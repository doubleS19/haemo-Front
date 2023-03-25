import 'package:get/get.dart';
import 'package:hae_mo/page/home_page.dart';
import "dart:developer" as dev;

enum RegisterState { Success, Fail, Empty, Okay }

class UserController extends GetxController {
  RegisterState _registerState = RegisterState.Fail;

  RegisterState get registerState => _registerState;

  Future checkUserInfo(String nickname, String major, String gender) async {
    if (nickname.isNotEmpty && major != "학과 선택" && gender != "성별") {
      _registerState = RegisterState.Okay;
      dev.log("Okay~");
    } else {
      _registerState = RegisterState.Empty;
      dev.log("Empty~");
    }
    update();
  }

  Future saveInfo(String nickname, String major, String gender) async {
    if (_registerState == RegisterState.Okay) {
      _registerState = RegisterState.Success;
      Get.to(const HomePage());
      dev.log("Success~");
    } else {
      _registerState = RegisterState.Fail;
      dev.log("Fail~");
    }
    update();
  }
}
