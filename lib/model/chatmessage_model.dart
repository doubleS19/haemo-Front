import 'dart:ffi';
import 'dart:ui';

class ChatMessage{
  String? text;
  String? image;
  String? sender;
  String? createdAt;

  ChatMessage({
    required this.text,
    required this.image,
    required this.sender,
    required this.createdAt,
  });

}