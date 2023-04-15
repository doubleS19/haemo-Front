import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class PostResponse {
  final String nickname;
  final String title;
  final String content;
  final int person;
  final String category;
  final String createdAt;
  final int type;
  final int pId;

  PostResponse(
      {required this.nickname,
      required this.title,
      required this.content,
      required this.person,
      required this.category,
      required this.createdAt,
      required this.type,
      required this.pId});

  factory PostResponse.fromJson(Map<String, dynamic> json) {
    return PostResponse(
        nickname: json['nickname'],
        title: json['title'],
        content: json['content'],
        person: json['person'],
        category: json['category'],
        createdAt: json['createdAt'],
        type: json['type'],
        pId: json['pid']);
  }

  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'title': title,
        'content': content,
        'person': person,
        'category': category,
        'createdAt': createdAt,
        'type': type,
        'pid': pId
      };
}
