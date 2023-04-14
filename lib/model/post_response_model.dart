import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class PostResponse {
  final int pId;
  final String nickname;
  final String title;
  final String content;
  final int person;
  final String category;
  final String createdAt;
  final int type;

  PostResponse(
      {required this.pId,
      required this.nickname,
      required this.title,
      required this.content,
      required this.person,
      required this.category,
      required this.createdAt,
      required this.type});

  factory PostResponse.fromJson(Map<String, dynamic> json) {
    return PostResponse(
        pId: json['pId'],
        nickname: json['nickname'],
        title: json['title'],
        content: json['content'],
        person: json['person'],
        category: json['category'],
        createdAt: json['createdAt'],
        type: json['type']);
  }

  Map<String, dynamic> toJson() => {
        'pId': pId,
        'nickname': nickname,
        'title': title,
        'content': content,
        'person': person,
        'category': category,
        'createdAt': createdAt,
        'type': type
      };
}
