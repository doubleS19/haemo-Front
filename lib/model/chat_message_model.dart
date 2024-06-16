import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String content;
  final bool isRead;
  final int sendTime;
  final int sender;

  ChatMessage({
    required this.content,
    required this.isRead,
    required this.sendTime,
    required this.sender,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      content: json['content'],
      isRead: json['isRead'],
      sendTime: json['sendTime'],
      sender: json['sender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'isRead': isRead,
      'sendTime': sendTime,
      'sender': sender,
    };
  }
}
