import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:haemo/model/hotplace_post_model.dart';
import 'package:haemo/service/db_service.dart';
import '../model/club_post_model.dart';
import '../model/post_model.dart';
import '../model/post_type.dart';
import '../utils/shared_preference.dart';
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
  final Rx<String> selectedHour = ''.obs;
  final RxList<MultipartFile?> selectedPhoto = [null].obs;
  final RxList<String?> hashTag = [null].obs;
  late Rx<Post> post = Post(
          nickname: "",
          title: "",
          content: "",
          person: 0,
          category: "",
          deadline: "",
          date: "",
          wishCnt: 0)
      .obs;
  late Rx<ClubPost> clubPost = ClubPost(
          nickname: "",
          title: "",
          description: "",
          content: "",
          person: 0,
          wishCnt: 0)
      .obs;
  late Rx<HotPlacePost> hotPlacePost = HotPlacePost(
          nickname: "",
          date: "",
          title: "",
          address: "",
          description: "",
          content: "",
          photoList: [],
          wishCnt: 0)
      .obs;

  PostController(PostType type) {
    postType = type;
  }

  void deleteData() {
    textControllerList[0].clear();
    textControllerList[1].clear();
    detailTextContext.clear();
  }

  void saveControllerData() {
    var nickname = PreferenceUtil.getString("nickname") ?? "a";

    switch (postType) {
      case PostType.meeting:
        post.update((post) {
          post?.title = textControllerList[0].text;
          post?.content = detailTextContext.text;
          post?.nickname = nickname;
          post?.category = selectedCategory.value;
          post?.person = selectedPerson.value;
          post?.deadline = getDeadLineFormat();
          post?.date = getNow();
          post?.wishCnt = 0;
        });
        break;
      case PostType.club:
        clubPost.update((clubPost) {
          clubPost?.nickname = nickname;
          clubPost?.title = textControllerList[0].text;
          clubPost?.description = textControllerList[1].text;
          clubPost?.content = detailTextContext.text;
          clubPost?.person = selectedPerson.value;
          clubPost?.logo = null;
          clubPost?.hashTag = [''];
          clubPost?.wishCnt = 0;
        });
        break;
      case PostType.hotPlace:
        hotPlacePost.update((hotPlacePost) {
          hotPlacePost?.nickname = nickname;
          hotPlacePost?.title = textControllerList[0].text;
          hotPlacePost?.description = textControllerList[1].text;
          hotPlacePost?.content = detailTextContext.text;
          hotPlacePost?.date = getNow();
          //hotPlacePost?.photoList = [];
          hotPlacePost?.wishCnt = 0;
        });
        break;
    }
  }

  String getDeadLineFormat() {
    String deadLine =
        "${selectedYear.value} ${selectedMonth.value} ${selectedDay.value} ${selectedHour.value}";

    return deadLine;
  }

  /// Empty라면 true 아니면 false
  bool checkEmpty() {
    bool isEmpty = true;
    switch (postType) {
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
    switch (postType) {
      case PostType.meeting:
        isPostSaved = await db.savePost(post.value);
        break;
      case PostType.club:
        isPostSaved = await db.saveClubPost(clubPost.value);
        break;
      case PostType.hotPlace:
        isPostSaved = await db.saveHotPlacePost(hotPlacePost.value);
        break;
    }
    return isPostSaved;
    // Fluttertoast.showToast(msg: "회원 정보를 저장할 수 없습니다.\n잠시 후 다시 시도해주세요.");
    update();
  }
}
