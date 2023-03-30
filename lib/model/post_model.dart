import 'dart:ffi';

import 'package:flutter/foundation.dart';

class Post {
  String? nickname;
  String? title;
  String? content;
  Int? pId;
  Int? person;
  String? category;

  Post(
      {required this.nickname,
      required this.title,
      required this.content,
      required this.pId,
      required this.person,
      required this.category});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        nickname: json['nickname'],
        title: json['title'],
        content: json['content'],
        pId: json['pId'],
        person: json['person'],
        category: json['category']);
  }
}
