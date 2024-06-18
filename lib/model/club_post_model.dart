import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:haemo/model/post_model.dart';

class ClubPost extends PostBase {
  late int person;
  late String? logo;

  /// 널 긊 불가/로고 없을 경우 사용할 기본 이미지 나중에 설정하기
  late String description;
  List<String>? hashTag;
  late String date;

  ClubPost(
      {required String nickname,
      required String title,
      required String description,
      required String content,
      this.logo,
      required this.person,
      this.hashTag,
      required this.date,
      required int wishCnt})
      : super(nickname: nickname, title: title, content: content, wishCnt: 0);

  factory ClubPost.fromJson(Map<String, dynamic> json) {
    return ClubPost(
        nickname: json['nickname'],
        title: json['title'],
        content: json['content'],
        description: json['description'],
        person: json['person'],
        logo: json['logo'],
        hashTag: json['hashTag'],
        wishCnt: 0,
        date: json['date']

        /// 멀티파트 이미지 리스트 DB로 전송
        );
  }

  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'title': title,
        'content': content,
        'description': description,
        'person': person,
        'logo': logo,
        'hashTag': hashTag,
        'wishClubCnt': wishCnt,
        'date': date

        /// 멀티파트 이미지 리스트 변수 넣기
      };
}
