import 'package:get/get.dart';
import 'package:hae_mo/model/post_model.dart';
import 'package:hae_mo/page/home_page.dart';
import 'package:hae_mo/service/db_service.dart';
import "dart:developer" as dev;

enum BoardRegisterState { full, empty }

enum BoardState { success, fail }

class BoardRegisterController extends GetxController {
  BoardRegisterState _BoardRegisterState = BoardRegisterState.empty;

  BoardRegisterState get boardRegisterState => _BoardRegisterState;

  BoardState _BoardState = BoardState.fail;
  BoardState get boardState => _BoardState;

  Future checkEssentialInfo(
      String person, String title, String content, String category) async {
    if (content.isNotEmpty &&
        title.isNotEmpty &&
        person != "인원 선택" &&
        category != "카테고리 선택") {
      _BoardRegisterState = BoardRegisterState.full;
      dev.log("Full~");
    } else {
      _BoardRegisterState = BoardRegisterState.empty;
      dev.log("Empty~");
    }
    update();
  }

  Future<void> saveBoard(
      String person, String title, String content, String category) async {
    if (_BoardRegisterState == BoardRegisterState.full) {
      DBService db = DBService();
      _BoardState = BoardState.success;
      db.savePost(Post(
          nickname: "닉네임입니다용",
          title: title,
          content: content,
          person: person,
          category: category));
      Get.to(const HomePage());
      dev.log("Success~");
    } else {
      _BoardState = BoardState.fail;
      dev.log("Fail~");
    }
    update();
  }
}
