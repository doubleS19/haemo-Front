import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:haemo/model/post_model.dart';

class HotPlacePost extends PostBase {
  late String description;
  String address;
  late String date;
  List<MultipartFile>? photoList;

  HotPlacePost(
      {required String nickname,
      required String title,
      required this.description,
      required this.address,
      required String content,
      required String date,
      this.photoList,
      required int wishCnt})
      : super(nickname: nickname, title: title, content: content, wishCnt: 0);

  factory HotPlacePost.fromJson(Map<String, dynamic> json) {
    return HotPlacePost(
        nickname: json['nickname'],
        title: json['title'],
        content: json['content'],
        address: json['address'],
        description: json['description'],
        //photoList: json['photoList'],
        date: json['date'],
        wishCnt: 0

        /// 멀티파트 이미지 리스트 DB로 전송
        );
  }

  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'title': title,
        'content': content,
        'description': description,
        'address': address,
        //'photoList': photoList,
        'date': date,
        'wishing': wishCnt

        /// 멀티파트 이미지 리스트 변수 넣기
      };
}
