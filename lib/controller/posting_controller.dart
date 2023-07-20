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

class PostController extends GetxController {
  final List<TextEditingController> textControllerList = [
    TextEditingController(),
    TextEditingController()
  ];
  final detailTextContext = TextEditingController();


  // nickname 가져오기
  final post = Post(
      nickname: PreferenceUtil.getString("nickname") ?? "a",

      /// 임시
      title: '',
      content: '',
      person: 0,
      category: '',
      date: '')
      .obs;

  final clubPost = ClubPost(
      nickname: PreferenceUtil.getString("nickname") ?? "a",
      title: '',
      content: '',
      person: 0,
      category: '',
      photo: [],
      date: ''
  ).obs;

  final hotPlacePost = HotPlacePost(
      nickname: PreferenceUtil.getString("nickname") ?? "a",
      title: '',
      content: '',
      date: '',
      description: ''
  ).obs;


  changePost({
    required String title,
    required String content,
    required int person,
    required String category,
    required String date,
  }) {
    post.update((val) {
      val?.title = title;
      val?.content = content;
      val!.person = person;
    });
  }

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

  final Rx<PostBase?> activePost = Rx<PostBase?>(null);


  PostController(PostType type) {

    StreamController<PostBase?> combinedPost = StreamController<PostBase?>();

    ever(post, (Post? postValue) {
      if (type != PostType.club) {
        combinedPost.add(postValue);
      }
    });

    ever(clubPost, (ClubPost? clubPostValue) {
      if (type == PostType.club) {
        combinedPost.add(clubPostValue);
      }
    });

    ever(hotPlacePost, (HotPlacePost? hotPlacePostValue) {
      if (type == PostType.hotPlace) {
        combinedPost.add(hotPlacePostValue);
      }
    });

    activePost.bindStream(combinedPost.stream);

    for (final controller in textControllerList) {
      controller.addListener(() {
        saveTextControllerData(type);
      });

      detailTextContext.addListener(() {
        saveTextControllerData(type);
      });
    }
  }


  void saveTextControllerData(PostType type) {
    final title = textControllerList[0].text;
    final description = textControllerList[1].text;
    final detailText = detailTextContext.text;
    switch (type) {
      case PostType.hotPlace:
        hotPlacePost.update((val) {
          val?.title = title;
          val?.content = detailText;
        });
        break;
      case PostType.club:
        clubPost.update((val) {
          val?.title = title;
          val?.content = detailText;
        });
        break;
      case PostType.meeting:
        post.update((val) {
          val?.title = title;
          val?.content = detailText;
        });
        break;
    }
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
