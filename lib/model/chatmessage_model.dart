import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatUser {
  String studentId;
  int profileImage;

  ChatUser({required this.studentId, required this.profileImage});

  factory ChatUser.fromJson(Map<String, dynamic> json){
    return ChatUser(
      studentId: json['studentId'],
      profileImage: json['profileImage']
    );
  }
  toJson(){
    return {
      'studentId': studentId,
      'profileImage' : profileImage
    };
  }
}

class ChatMessage {
  String text;
  String sender;
  DateTime createdAt; //  임시
  bool isRead;

  ChatMessage(
      {required this.text,
      required this.sender,
      required this.createdAt,
      required this.isRead});

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      text: json['text'],
      sender: json['sender'],
      createdAt: json['createdAt'].toDate(),
      isRead: json['isRead']
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['text'] = text;
    data['sender'] = sender;
    data['createdAt'] = createdAt;
    data['isRead'] = isRead;
    return data;
  }

  toJson(){
    return {
      'text' : text,
      'sender' : sender,
      'createdAt': createdAt,
      'isRead': isRead
    };
  }
}

class ChatData {
  String? chatRoomId;
  ChatUser? chatUser1;
  ChatUser? chatUser2;
  List<ChatMessage>? chatMessageList;

  ChatData(
      {required this.chatRoomId,
      required this.chatUser1,
      required this.chatUser2,
      required this.chatMessageList});

  // Json to data
  factory ChatData.fromJson(Map<String, dynamic> json) {
    return ChatData(
        chatRoomId: json['text'],
        chatUser1: json['chatUser1'].map((user) => ChatUser.fromJson(user)),
        chatUser2: json['chatUser2'].map((user) => ChatUser.fromJson(user)),
        chatMessageList: json['messageList'].map((message) => ChatMessage.fromJson(message)).toList()
    );
  }

  factory ChatData.fromDocumentSnapshot(DocumentSnapshot snapshot){
    final List<ChatMessage> message = [];
    final messageShapshot = List<Map>.from(snapshot['chatMessageList'] as List);
    for (var a in messageShapshot){
      message.add(ChatMessage.fromJson(a as Map<String, dynamic>));
    }

    return ChatData(
      chatRoomId: snapshot['chatRoomId'],
      chatUser1: ChatUser.fromJson(snapshot['chatUser1'] as Map<String, dynamic>),
      chatUser2: ChatUser.fromJson(snapshot['chatUser2'] as Map<String, dynamic>),
      chatMessageList: message
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chatRoomId' : chatRoomId,
      'chatUser1' : chatUser1?.toJson(),
      'chatUser2' : chatUser2?.toJson(),
      'chatMessageList' :  chatMessageList!.map((message) => message.toJson()).toList(),
    };
  }
}
