import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  String messageText;
  String sentBy;
  DateTime sentAt;
  bool isRead;

  ChatMessage({
    required this.messageText,
    required this.sentBy,
    required this.sentAt,
    required this.isRead,
  });

  Map<String, dynamic> toJson() {
    return {
      'messageText': messageText,
      'sentBy': sentBy,
      'sentAt': sentAt.toUtc().toIso8601String(),
      // Convert DateTime to ISO 8601 string
      'isRead': isRead,
    };
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      messageText: json['messageText'],
      sentBy: json['sentBy'],
      sentAt: DateTime.parse(json['sentAt']),
      isRead: json['isRead'],
    );
  }
}
