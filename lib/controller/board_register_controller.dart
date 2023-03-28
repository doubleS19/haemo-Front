import 'package:get/get.dart';
import 'package:hae_mo/page/home_page.dart';
import "dart:developer" as dev;

enum BoardRegisterState { Full, Empty }

enum BoardState { Success, Fail }

class BoardRegisterController extends GetxController {
  BoardRegisterState _BoardRegisterState = BoardRegisterState.Empty;

  BoardRegisterState get boardRegisterState => _BoardRegisterState;

  BoardState _BoardState = BoardState.Fail;
  BoardState get boardState => _BoardState;

  Future checkEssentialInfo(
      String person, String title, String content, String category) async {
    if (content.isNotEmpty &&
        title.isNotEmpty &&
        person != "인원 선택" &&
        category != "카테고리 선택") {
      _BoardRegisterState = BoardRegisterState.Full;
      dev.log("Full~");
    } else {
      _BoardRegisterState = BoardRegisterState.Empty;
      dev.log("Empty~");
    }
    update();
  }

  Future saveBoard(String nickname, String major, String gender) async {
    if (_BoardRegisterState == BoardRegisterState.Full) {
      _BoardState = BoardState.Success;
      Get.to(const HomePage());
      dev.log("Success~");
    } else {
      _BoardState = BoardState.Fail;
      dev.log("Fail~");
    }
    update();
  }
}
