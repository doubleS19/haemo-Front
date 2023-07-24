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
  late PostType postType;

  final Rx<int> selectedPerson = 0.obs;
  final Rx<String> selectedCategory = ''.obs;
  final Rx<String> selectedYear = ''.obs;
  final Rx<String> selectedMonth = ''.obs;
  final Rx<String> selectedDay = ''.obs;
  final RxList<MultipartFile?> selectedPhoto = [null].obs;
  final RxList<String?> hashTag = [null].obs;
  late final Post post;
  late final ClubPost clubPost;
  late final HotPlacePost hotPlacePost;

  PostController(PostType type){
   postType = type;
  }

  void saveControllerData() {
    var nickname = PreferenceUtil.getString("nickname") ?? "a";
    switch (postType) {
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
        clubPost = ClubPost(
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
        hotPlacePost = HotPlacePost(
            nickname: nickname,
            title: textControllerList[0].text,
            description: textControllerList[1].text,
            content: detailTextContext.text,
            date: getNow(),
            photoList: []);
        break;
    }
  }

  String getDeadLineFormat() {
    String deadLine =
        "${selectedYear.value} ${selectedMonth.value} ${selectedDay.value}";

    return deadLine;
  }

  /// Empty라면 true 아니면 false
  bool checkEmpty(){
    bool isEmpty = true;
    switch(postType){
      case PostType.meeting:
        isEmpty = textControllerList[0].text.isEmpty;
        isEmpty = detailTextContext.text.isEmpty;
        return isEmpty;
      case PostType.club:
        isEmpty = textControllerList[0].text.isEmpty;
        isEmpty = textControllerList[1].text.isEmpty;
        isEmpty = detailTextContext.text.isEmpty;
        return isEmpty;
      case PostType.hotPlace:
        isEmpty = textControllerList[0].text.isEmpty;
        isEmpty = textControllerList[1].text.isEmpty;
        isEmpty = detailTextContext.text.isEmpty;
        return isEmpty;
    }
  }

    Future<bool> saveBoard() async {
        DBService db = DBService();
        bool isPostSaved = false;
        switch(postType){
          case PostType.meeting:
            isPostSaved = await db.savePost(post);
            break;
          case PostType.club:
            isPostSaved = await db.saveClubPost(clubPost);
            break;
          case PostType.hotPlace:
            isPostSaved = await db.saveHotPlacePost(hotPlacePost);
            break;
        }
        return isPostSaved;
        // Fluttertoast.showToast(msg: "회원 정보를 저장할 수 없습니다.\n잠시 후 다시 시도해주세요.");
      update();
    }
}
