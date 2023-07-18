import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hae_mo/service/db_service.dart';
import "dart:developer" as dev;

import 'package:intl/intl.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../model/post_model.dart';
import '../screens/Page/home_page.dart';

enum BoardRegisterState { full, empty }

enum BoardState { success, fail }

class PostController extends GetxController {
  BoardRegisterState _BoardRegisterState = BoardRegisterState.empty;

  BoardRegisterState get boardRegisterState => _BoardRegisterState;

  BoardState _BoardState = BoardState.fail;
  BoardState get boardState => _BoardState;

  final List<TextEditingController> textControllerList = [
    TextEditingController(),
    TextEditingController()
  ];
  final detailTextContext = TextEditingController();

  Future checkEssentialInfo(
      String person, String title, String content, String category) async {
    if (content.isNotEmpty &&
        title.isNotEmpty &&
        person != "" &&
        person != "0" &&
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
      int person, String title, String content, String category) async {
    if (_BoardRegisterState == BoardRegisterState.full) {
      String date = DateFormat("yyyy년 MM월 dd일 HH시").format(DateTime.now());
      DBService db = DBService();
      _BoardState = BoardState.success;
      Post post = Post(
          nickname: "닉네임입니다용",
          title: title,
          content: content,
          person: person,
          category: category,
          date: date);
      db.savePost(post);
      bool isPostSaved = await db.savePost(post);
      if (isPostSaved) {
        Get.to(const HomePage());
      }
    } else {
      _BoardState = BoardState.fail;
      // Fluttertoast.showToast(msg: "회원 정보를 저장할 수 없습니다.\n잠시 후 다시 시도해주세요.");
      dev.log("Fail~");
    }
    update();
  }
}
