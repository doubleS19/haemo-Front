import 'dart:ffi';

import 'package:get/get_connect/http/src/multipart/multipart_file.dart';

class HotPlacePostResponse {
  int pId;
  String title;
  String content;
  String nickname;
  String date;
  String? address;
  List<String?> photoList;
  int heartNum = 0;

  HotPlacePostResponse(
      {required this.pId,
      required this.title,
      required this.content,
      required this.address,
      required this.nickname,
      required this.date,
      required this.photoList,
      required this.heartNum});

  factory HotPlacePostResponse.fromJson(Map<String, dynamic> json) {
    return HotPlacePostResponse(
      title: json['title'],
      content: json['content'],
      nickname: json['nickname'],
      address: json['address'],
      date: json['date'],
      pId: json['hpId'],
      photoList: List<String>.from(json['imageList']),
      heartNum: json['wishing'],

      /// 멀티파트 이미지 리스트 DB로 전송
    );
  }

  Map<String, dynamic> toJson() => {
        'hpId': pId,
        'title': title,
        'content': content,
        'nickname': nickname,
        'date': date,
        'address': address,
        'imageList': photoList,
        'wishing': heartNum

        /// 멀티파트 이미지 리스트 변수 넣기
      };
}
