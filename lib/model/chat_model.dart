import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'chat_message_model.dart';

// class ChatRoom {
//   Long createdAt;
//   int createdBy;
//   String id;
//   bool isDeleted;
//   List<int> membersId;
//   ChatMessage recentMessage;

//   ChatRoom({
//     required this.createdAt,
//     required this.createdBy,
//     required this.id,
//     required this.isDeleted,
//     required this.membersId,
//     required this.recentMessage,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'createdAt': createdAt,
//       'createdBy': createdBy,
//       'id': id,
//       'isDeleted': isDeleted,
//       'members': membersId,
//       'recentMessage': recentMessage.toJson(),
//     };
//   }

//   factory ChatRoom.fromJson(Map<String, dynamic> json) {
//     return ChatRoom(
//       createdAt: json['createdAt'],
//       createdBy: json['createdBy'],
//       id: json['id'],
//       isDeleted: json['isDeleted'],
//       membersId: List<int>.from(json['membersId']),
//       recentMessage: ChatMessage.fromJson(json['recentMessage']),
//     );
//   }
// }

class FireBaseChatModel {
  String? id;
  ChatUserModel sender;
  ChatUserModel receiver;
  List<ChatMessageModel> messages;

  FireBaseChatModel({
    this.id,
    required this.sender,
    required this.receiver,
    required this.messages,
  });

  factory FireBaseChatModel.fromJson(Map<String, dynamic> json) {
    return FireBaseChatModel(
      id: json['id'],
      sender: ChatUserModel.fromJson(json['sender']),
      receiver: ChatUserModel.fromJson(json['receiver']),
      messages: (json['messages'] as List)
          .map((message) => ChatMessageModel.fromJson(message))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender': sender.toJson(),
      'receiver': receiver.toJson(),
      'messages': messages.map((message) => message.toJson()).toList(),
    };
  }
}

class ChatUserModel {
  int? id;
  String nickname;

  ChatUserModel({
    this.id,
    required this.nickname,
  });

  factory ChatUserModel.fromJson(Map<String, dynamic> json) {
    return ChatUserModel(
      id: json['id'],
      nickname: json['nickname'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nickname': nickname,
    };
  }
}

class ChatMessageModel {
  String content;
  int createdAt;
  int from;
  String senderNickname;
  bool isRead;

  ChatMessageModel({
    this.content = "",
    this.createdAt = 0,
    this.from = 0,
    this.senderNickname = "",
    this.isRead = false,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      content: json['content'],
      createdAt: json['createdAt'],
      from: json['from'],
      senderNickname: json['senderNickname'],
      isRead: json['isRead'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'createdAt': createdAt,
      'from': from,
      'senderNickname': senderNickname,
      'isRead': isRead,
    };
  }
}
