import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class Post {
  final String nickname;
  final String title;
  final String content;
  final int person;
  final String category;
  final String date;
  final int type;

  Post(
      {required this.nickname,
      required this.title,
      required this.content,
      required this.person,
      required this.category,
      required this.date,
      required this.type});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        nickname: json['nickname'],
        title: json['title'],
        content: json['content'],
        person: json['person'],
        category: json['category'],
        date: json['date'],
        type: json['type']);
  }

  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'title': title,
        'content': content,
        'person': person,
        'category': category,
        'date': date,
        'type': type
      };
}
