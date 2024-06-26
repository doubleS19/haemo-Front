import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  final int studentId;
  final String nickname;
  final String major;
  final String gender;
  final int userImage;

  User(
      {required this.studentId,
      required this.nickname,
      required this.major,
      required this.gender,
      required this.userImage});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        studentId: json['studentId'],
        nickname: json['nickname'],
        major: json['major'],
        gender: json['gender'],
        userImage: json['user_image']);
  }
  Map<String, dynamic> toJson() => {
        'studentId': studentId,
        'nickname': nickname,
        'major': major,
        'gender': gender,
        'user_image': userImage
      };
}

Future<List<User>> fetchUser() async {
  final response = await http.get(Uri.parse("3.34.190.238:8080/user"));
  if (response.statusCode == 200) {
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  } else {
    throw Exception("Failed to fetch User");
  }
}
