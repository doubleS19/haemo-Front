import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:hae_mo/model/post_model.dart';

class ClubPost extends PostBase {
  late int person;
  late MultipartFile? photo;
  late String description;
  List<String>? hashTag;

  ClubPost(
      {required String nickname,
      required String date,
      required String title,
      required String description,
      required String content,
      this.photo,
      required this.person,
      this.hashTag})
      : super(
          nickname: nickname,
          title: title,
          content: content,
          date: date,
        );

  factory ClubPost.fromJson(Map<String, dynamic> json) {
    return ClubPost(
        nickname: json['nickname'],
        date: json['date'],
        title: json['title'],
        content: json['content'],
        description: json['description'],
        person: json['person'],
        photo: json['photo'],
        hashTag: json['hashTag']

        /// 멀티파트 이미지 리스트 DB로 전송
        );
  }

  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'title': title,
        'content': content,
        'description': description,
        'date': date,
        'person': person,
        'photo': photo,
        'hashTag': hashTag

        /// 멀티파트 이미지 리스트 변수 넣기
      };
}
