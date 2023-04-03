import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';


class ChatUser {
  String? name;
  Int? profileImage;
}

class ChatMessage {
  String? text;
  String? sender;
  Timestamp? createdAt;
}


class ChatData {
  ChatUser? chatUser1;
  ChatUser? chatUser2;
  List<ChatMessage>? chatMessageList;

  ChatData({
    required this.chatUser1,
    required this.chatUser2,
    required this.chatMessageList
  });

  // Map to data
  factory ChatData.fromMap({
    required ChatUser chatUser1,
    required ChatUser chatUser2,
    required List<ChatMessage> chatMessageList }){
    return ChatData(
      chatUser1: chatUser1,
      chatUser2: chatUser2,
      chatMessageList: chatMessageList
    );
  }

  Map<String, dynamic> toFirestore() {
    Map<String, dynamic> data = {};
    data['chatUser1'] = chatUser1;
    data['chatUser2'] = chatUser2;
    data['chatMessageList'] = chatMessageList;
    return data;
  }


}