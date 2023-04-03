import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class User {
  final String? nickname;
  final String? major;
  final String? gender;

  User({required this.nickname, required this.major, required this.gender});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        nickname: json['nickname'],
        major: json['major'],
        gender: json['gender']);
  }
  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'major': major,
        'gender': gender,
      };
}

Future<List<User>> fetchUser() async {
  final response = await http.get(Uri.parse("http://localhost:8080/user"));
  if (response.statusCode == 200) {
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  } else {
    throw Exception("Failed to fetch User");
  }
}
