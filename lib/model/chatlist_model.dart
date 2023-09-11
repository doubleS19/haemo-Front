import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'chat_message_model.dart';

class ChatList{
  DateTime createdAt;
  String createdBy;
  String id;
  bool isDeleted;
  List<String> members;
  ChatMessage recentMessage;

  ChatList({
    required this.createdAt,
    required this.createdBy,
    required this.id,
    required this.isDeleted,
    required this.members,
    required this.recentMessage,
  });

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt.toUtc(),
      'createdBy': createdBy,
      'id': id,
      'isDeleted': isDeleted,
      'members': members,
      'recentMessage': recentMessage.toJson(),
    };
  }

  factory ChatList.fromJson(Map<String, dynamic> json) {
    return ChatList(
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt'].millisecondsSinceEpoch).toUtc(),
      createdBy: json['createdBy'],
      id: json['id'],
      isDeleted: json['isDeleted'],
      members: List<String>.from(json['members']),
      recentMessage: ChatMessage.fromJson(json['recentMessage']),
    );
  }
}

/*
chatList.add(Chat(nickname: "정왕동 뿡뿡이", message: "Hari Prasad Chaudhary"));
chatList.add(Chat(nickname: "정직한 정서연", message: "Krishna Karki") as ChatList);
chatList.add(Chat(nickname: "귀찮은 송미란", message: "Hari Prasad Chaudhary"));
chatList.add(Chat(nickname: "ㅎㅎㅅ", message: "Krishna Karki"));
chatList.add(Chat(nickname: "ㅇㅅㅊ", message: "Hari Prasad Chaudhary"));
chatList.add(Chat(nickname: "ㅂㅈㅁ", message: "Krishna Karki"));
chatList.add(Chat(nickname: "ㅅㅇㅅ 렛츠고", message: "Hari Prasad Chaudhary"));
chatList.add(Chat(nickname: "어리둥절빙글빙글", message: "Krishna Karki"));
chatList.add(Chat(nickname: "돌아가는", message: "Hari Prasad Chaudhary"));
chatList.add(Chat(nickname: "쨍구의하루", message: "Krishna Karki"));
chatList.add(Chat(nickname: "또라에모옹도와죠", message: "Hari Prasad Chaudhary"));
chatList.add(Chat(nickname: "인천섹시남", message: "Krishna Karki"));*/
