import 'dart:ffi';

class ChatMessage{
  String? text;
  String? sender;
  DateTime createdAt;

  ChatMessage({
    required this.text,
    required this.sender,
    required this.createdAt,
  });
}