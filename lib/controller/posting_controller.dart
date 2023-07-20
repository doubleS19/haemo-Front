import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hae_mo/model/hotplace_post_model.dart';
import 'package:hae_mo/service/db_service.dart';
import "dart:developer" as dev;

import 'package:intl/intl.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../model/club_post_model.dart';
import '../model/post_model.dart';
import '../model/post_type.dart';
import '../model/shared_preference.dart';
import '../screens/Page/home_page.dart';
import '../service/date_service.dart';

class PostController extends GetxController {
  final List<TextEditingController> textControllerList = [
    TextEditingController(),
    TextEditingController()
  ];
  final detailTextContext = TextEditingController();

  final Rx<int> selectedPerson = 0.obs;
  final Rx<String> selectedCategory = ''.obs;
  final Rx<String> selectedYear = ''.obs;
  final Rx<String> selectedMonth = ''.obs;
  final Rx<String> selectedDay = ''.obs;
  final RxList<MultipartFile?> selectedPhoto = [null].obs;
  final RxList<String?> hashTag = [null].obs;

  late final Post post;

  final clubPost = ClubPost(
          nickname: PreferenceUtil.getString("nickname") ?? "a",
          title: '',
          description: '',
          content: '',
          person: 0,
          photo: null,
          date: '')
      .obs;

  final hotPlacePost = HotPlacePost(
          nickname: PreferenceUtil.getString("nickname") ?? "a",
          title: '',
          content: '',
          date: '',
          description: '')
      .obs;

  // changePost({
  //   required String title,
  //   required String content,
  //   required int person,
  //   required String category,
  //   required String date,
  // }) {
  //   post.update((val) {
  //     val?.title = title;
  //     val?.content = content;
  //     val!.person = person;
  //   });
  // }

  changeClubPost({
    required String title,
    required String content,
    required int person,
    required String category,
  }) {
    clubPost.update((val) {
      val?.title = title;
      val?.content = content;
      val!.person = person;
    });
  }

  changeHotPlacePost({
    required String title,
    required String content,
    required String description,
    MultipartFile? photo,
  }) {
    hotPlacePost.update((val) {
      val?.title = title;
      val?.content = content;
      val?.description = description;
      val?.photo = photo;
    });
  }

  PostController(PostType type) {
/*    ever(selectedYear, (String yearValue) {
      saveTextControllerData(type);
    });

    ever(selectedMonth, (String monthValue) {

    });

    ever(selectedDay, (String dayValue) {

    });*/
  }

  // void savePostControllerData(PostType type) {
  //   final title = textControllerList[0].text;
  //   final description = textControllerList[1].text;
  //   final detailText = detailTextContext.text;
  //   final date = DateTime.now();
  //   switch (type) {
  //     case PostType.meeting:
  //       post.update((val) {
  //         val?.title = title;
  //         val?.content = detailText;
  //       });
  //       break;
  //     case PostType.club:
  //       clubPost.update((val) {
  //         val?.title = title;
  //         val?.content = detailText;
  //       });
  //       break;
  //     case PostType.hotPlace:
  //       hotPlacePost.update((val) {
  //         val?.title = title;
  //         val?.content = detailText;
  //       });
  //       break;
  //   }
  // }

  void saveControllerData(PostType type) {
    var nickname = PreferenceUtil.getString("nickname") ?? "a";
    final PostBase post;

    switch (type) {
      case PostType.meeting:
        post = Post(
          title: textControllerList[0].text,
          content: detailTextContext.text,
          nickname: nickname,
          category: selectedCategory.value,
          person: selectedPerson.value,
          deadline: getDeadLineFormat(),
          date: getNow(),
        );
        break;
      case PostType.club:
        post = ClubPost(
          nickname: nickname,
          date: getNow(),
          title: textControllerList[0].text,
          description: textControllerList[1].text,
          content: detailTextContext.text,
          person: selectedPerson.value,
          photo: null,
          hashTag: [''],
        );
        break;
      case PostType.hotPlace:
        post = HotPlacePost(
            nickname: nickname,
            title: textControllerList[0].text,
            description: textControllerList[1].text,
            content: detailTextContext.text,
            date: getNow());

        break;
    }
  }

  String getDeadLineFormat() {
    String deadLine =
        "${selectedYear.value} ${selectedMonth.value} ${selectedDay.value}";

    return deadLine;
  }

/*    Future checkEssentialInfo(String person, String title, String content,
        String category) async {
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
    }*/

/*    Future<void> saveBoard(int person, String title, String content,
        String category) async {
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
    }*/
}
