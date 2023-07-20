import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:hae_mo/model/post_model.dart';

class ClubPost extends PostBase {
  late int person;
  late String category;
  late List<MultipartFile> photo;

  ClubPost(
      {required String nickname,
      required String title,
      required String content,
      required String date,
      required this.person,
      required this.category,
      required this.photo})
      : super(
          nickname: nickname,
          title: title,
          content: content,
          date: date,
        );

  factory ClubPost.fromJson(Map<String, dynamic> json) {
    return ClubPost(
      nickname: json['nickname'],
      title: json['title'],
      content: json['content'],
      date: json['date'],
      person: json['person'],
      category: json['category'],
      photo: json[''],

      /// 멀티파트 이미지 리스트 DB로 전송
    );
  }

  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'title': title,
        'content': content,
        'date': date,
        'person': person,
        'category': category,
        'photo': photo
        /// 멀티파트 이미지 리스트 변수 넣기
      };
}
