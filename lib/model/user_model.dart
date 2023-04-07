import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  final String studentId;
  final String nickname;
  final String major;
  final String gender;

  User({required this.studentId, required this.nickname, required this.major, required this.gender});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        studentId: json['studentId'],
        nickname: json['nickname'],
        major: json['major'],
        gender: json['gender']);
  }
  Map<String, dynamic> toJson() => {
        'studentId': studentId,
        'nickname': nickname,
        'major': major,
        'gender': gender,
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
