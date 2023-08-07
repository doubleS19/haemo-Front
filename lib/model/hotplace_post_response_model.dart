import 'dart:ffi';

import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:hae_mo/model/post_model.dart';

class HotPlacePostResponse {
  int pId;
  String title;
  String content;
  String nickname;
  String date;
  List<MultipartFile> photoList;
  int heartNum;

  HotPlacePostResponse(
      {required this.pId,
      required this.title,
      required this.content,
      required this.nickname,
      required this.date,
      required this.photoList,
      required this.heartNum});

  factory HotPlacePostResponse.fromJson(Map<String, dynamic> json) {
    return HotPlacePostResponse(
      pId: json['pid'],
      title: json['title'],
      content: json['content'],
      nickname: json['nickname'],
      date: json['date'],
      photoList: json['photolist'],
      heartNum: json['heartnum'],

      /// 멀티파트 이미지 리스트 DB로 전송
    );
  }

  Map<String, dynamic> toJson() => {
        'pid': pId,
        'title': title,
        'content': content,
        'nickname': nickname,
        'date': date,
        'photoList': photoList,
        'heartnum': heartNum

        /// 멀티파트 이미지 리스트 변수 넣기
      };
}
