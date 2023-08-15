// import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hae_mo/model/user_response_model.dart';
import 'package:hae_mo/utils/shared_preference.dart';
import 'package:hae_mo/screens/page/home_page.dart';
import "dart:developer" as dev;

import 'package:hae_mo/service/db_service.dart';

import '../model/user_model.dart';

enum RegisterState { success, fail, empty, okay }

class UserController extends GetxController {
  RegisterState _registerState = RegisterState.fail;

  RegisterState get registerState => _registerState;

  Future checkUserInfo(String nickname, String major, String gender) async {
    if (nickname.isNotEmpty && major != "학과 선택" && gender != "성별") {
      _registerState = RegisterState.okay;
      dev.log("Okay~");
    } else {
      _registerState = RegisterState.empty;
      dev.log("Empty~");
    }
    update();
  }

  Future saveInfo(String nickname, String major, String gender) async {
    DBService dbService = DBService();

    if (_registerState == RegisterState.okay) {
      User user = User(
          studentId: "00000000",
          nickname: nickname,
          major: major,
          gender: gender,
          userImage: "assets/user_dog.png");
      _registerState = RegisterState.success;
      PreferenceUtil.saveUser(user);
      bool isUserSaved = await dbService.saveUser(user);
      if (isUserSaved) {
        UserResponse userResponse = await dbService.getUserByNickname(nickname);
        PreferenceUtil.setInt("uid", userResponse.uId);
        Get.to(const HomePage());
      } else {}
      dev.log(PreferenceUtil.getString("nickname")!);
    } else {
      _registerState = RegisterState.fail;
      dev.log("Fail~");
      // Fluttertoast.showToast(msg: "회원 정보를 저장할 수 없습니다.\n잠시 후 다시 시도해주세요.");
    }
    update();
  }
}
