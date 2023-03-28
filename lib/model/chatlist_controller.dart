import 'dart:ffi';

class ChatList{
  String? chatUser1;
  String? chatUser2;
  String? lastChat;
  Int? profileImg;
  Int? newChat;

  ChatList({
    required this.chatUser1,
    required this.chatUser2,
    required this.lastChat,
    required this.profileImg,
    required this.newChat
  });
}
