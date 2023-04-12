import 'dart:ffi';

// firebase chatList
class ChatList{
  String? chatRoomId;
  String? chatUser1;
  String? chatUser2;
  String? lastChat;
  Int? newChat;

  ChatList({
    required this.chatRoomId,
    required this.chatUser1,
    required this.chatUser2,
    required this.lastChat,
    required this.newChat
  });
}
