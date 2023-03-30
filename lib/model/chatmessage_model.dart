import 'dart:ffi';
import 'dart:ui';

class ChatMessage{
  String? text;
  String? image;
  String? sender;
  DateTime createdAt;

  ChatMessage({
    required this.text,
    required this.image,
    required this.sender,
    required this.createdAt,
  });

  List<ChatMessage> chats = [
    ChatMessage(
      text: "hi",
      image: "sf",
      sender: "seoyeon",
      createdAt: DateTime(2023, 2, 23, 3, 56)
    ),
    ChatMessage(
        text: "wow",
        image: "sf",
        sender: "nada",
        createdAt: DateTime(2023, 2, 23, 3, 68)
    )
  ];
}