import 'dart:convert';
import 'package:http/http.dart' as http;

class UserResponse {
  final int uId;
  final String studentId;
  final String nickname;
  final String major;
  final String gender;
  final String userImage;

  UserResponse(
      {required this.uId,
      required this.studentId,
      required this.nickname,
      required this.major,
      required this.userImage,
      required this.gender});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
        uId: json['uid'],
        studentId: json['studentId'],
        nickname: json['nickname'],
        major: json['major'],
        userImage: json['user_image'],
        gender: json['gender']);
  }
  Map<String, dynamic> toJson() => {
        'uid': uId,
        'studentId': studentId,
        'nickname': nickname,
        'major': major,
        'user_image': userImage,
        'gender': gender,
      };
}
