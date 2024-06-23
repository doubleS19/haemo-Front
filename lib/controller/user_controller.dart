// import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ffi';

import 'package:get/get.dart';
import 'package:haemo/model/user_response_model.dart';
import 'package:haemo/utils/shared_preference.dart';
import 'package:haemo/screens/page/home_page.dart';
import "dart:developer" as dev;

import 'package:haemo/service/db_service.dart';

import '../model/user_model.dart';

enum RegisterState { success, fail, empty, okay }

class UserController extends GetxController {
  RegisterState _registerState = RegisterState.fail;
  RegisterState get registerState => _registerState;

  DBService db = DBService();
  Rx<UserResponse?> user = Rx<UserResponse?>(null);
  final uId = PreferenceUtil.getInt("uId");
  bool isUserDeleted = false;

  Future checkUserInfo(String nickname, String major, String gender) async {
    if (nickname.isNotEmpty && major != "학과 선택" && gender != "성별") {
      _registerState = RegisterState.okay;
      dev.log("Register State: Okay~");
    } else {
      _registerState = RegisterState.empty;
      dev.log("Register State: Empty~");
    }
    update();
  }

  Future saveInfo(
      String nickname, String major, String gender, int image) async {
    if (_registerState == RegisterState.okay) {
      User user = User(
          studentId: PreferenceUtil.getInt("studentId")!,
          nickname: nickname,
          major: major,
          gender: gender,
          userImage: image);
      _registerState = RegisterState.success;
      // PreferenceUtil.saveUser(user);
      bool isUserSaved = await db.saveUser(user);
      if (isUserSaved) {
        UserResponse userResponse = await db.getUserByNickname(nickname);
        PreferenceUtil.setUser(userResponse);
        Get.to(const HomePage());
      } else {}
    } else {
      _registerState = RegisterState.fail;
      dev.log("Fail~");
      // Fluttertoast.showToast(msg: "회원 정보를 저장할 수 없습니다.\n잠시 후 다시 시도해주세요.");
    }
    update();
  }

  Future<bool> checkNickname(String nickname) async {
    bool isUsed = await db.checkNicknameDuplicate(nickname);
    return !isUsed;
  }

  void fetchBoardUser(int pId, int type) async {
    try {
      user.value = type == 1
          ? await db.getUserByPost(pId)
          : (type == 2
              ? await db.getUserByClubPost(pId)
              : await db.getUserByHotPlace(pId));
    } catch (e) {
      dev.log(e.toString());
    }
  }

  void deleteUser() async {
    try {
      print(uId!);
      await db.deleteUser(uId!).then((value) {
        if (value) {
          isUserDeleted = true;
          PreferenceUtil.clear();
          Get.offAllNamed("/");
        }
      });
    } catch (e) {
      dev.log(e.toString());
    }
  }
}
