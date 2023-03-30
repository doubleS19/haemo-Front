import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class Post {
  final String? nickname;
  final String? title;
  final String? content;
  final String? person;
  final String? category;

  Post(
      {required this.nickname,
      required this.title,
      required this.content,
      required this.person,
      required this.category});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        nickname: json['nickname'],
        title: json['title'],
        content: json['content'],
        person: json['person'],
        category: json['category']);
  }
  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'title': title,
        'content': content,
        'person': person,
        'category': category,
      };
}

Future<List<Post>> fetchPost() async {
  final response = await http.get(Uri.parse("http://localhost:8080/post"));
  if (response.statusCode == 200) {
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    return parsed.map<Post>((json) => Post.fromJson(json)).toList();
  } else {
    throw Exception("Failed to fetch Post");
  }
}
