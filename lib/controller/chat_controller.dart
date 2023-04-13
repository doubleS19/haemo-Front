import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hae_mo/page/chat_list_page.dart';
import 'package:http/http.dart';

import '../model/chatmessage_model.dart';
import '../model/shared_preference.dart';

class ChatController extends GetxController {
  final firestore = FirebaseFirestore.instance;
  late String chatRoomId = "";
  final RxString _text = "".obs;
  final RxString _sender = "".obs;
  final createdAt = DateTime.now();
  late List<ChatMessage> chatMessageList = [];

  get text => _text;
  get sender => _sender;

  StreamController<List<ChatMessage>> streamController = StreamController<List<ChatMessage>>();

  var message = ChatMessage(
      text: "",
      sender: "",
      createdAt: DateTime.now(),
      isRead: false
  ).obs;

  change({
    required String text,
    required String sender,
  }) {
    message.update((message) {
      message?.text = text;
      message?.sender = sender;
      message?.createdAt = DateTime.now();
      message?.isRead = false;
    });
  }

  void startStream(){

  }

  @override
  void onInit() {
    super.onInit();


    ever(message, (_) {
      chatMessageList.add(message.value);
      for (var i in chatMessageList) {
        print(i.text);
      }
    });
  }

  // 최초 메세지 전송 시 채팅방 생성 필요
  void createChatroom(ChatUser otherUser, ChatMessage chatMessage) {
    // me, other 사이에 생성된 채팅방이 있는지 확인 - 게시물에서 채팅으로 넘어갈 때 필요할 듯?
    // chatRoomId 여기서 생성해야 될 듯?

    late String createChatRoomId = "";
    var chatroom = ChatData(
      chatRoomId: createChatRoomId,
      chatUser1: ChatUser(
/*          studentId: PreferenceUtil.getString("studentId")!,
          profileImage: PreferenceUtil.getInt("profileImage") != null? PreferenceUtil.getInt("profileImage")! : 1*/
        studentId: "seoyeon",
        profileImage: 1
      ),
      chatUser2: otherUser,
      chatMessageList: [chatMessage]
    );

    streamController.sink.add([chatMessage]);

    firestore.collection('haemo').doc("first")
        .set(chatroom.toJson());

    // 자신의 채팅방 리스트에 추가해야 됨
    // UI 변화도 - Stream에서 메세지 받게 해서 할까?
  }


  // 메세지 전송 클릭 시 FireStore로 전송
  void sendData(String chatRoomId, ChatUser chatUser, ChatMessage chatMessage) async{
    try {
      final snapshot = await firestore.collection('haemo').doc(chatRoomId).get();

      if(snapshot.exists){


      } else{
        createChatroom(chatUser ,chatMessage);
      }
      change(text: text,
          sender: PreferenceUtil.getString("studentId")!,
      );

/*      firestore.collection('haemo/$chatRoomId/chat/messageList/message').update(
          message.value.toMap()).then((value) =>
          print("DocumentSnapshot added with ID: ${value.id}")
      );*/
    } catch (ex) {
      log('error', error: ex.toString(), stackTrace: StackTrace.current);
    }
  }

  // 메세지 읽었을 때 false -> true

  // 메시지 가져오기 - stream
  Stream<ChatData> streamChatMessage(String chatRoomId) {
    try {
      // charRoomId가 없으면 조회되지 않음

      final snapshots = firestore
          .collection('haemo')
          .doc(chatRoomId)
          .snapshots()
          .map((event) => ChatData.fromDocumentSnapshot(event));

      snapshots.listen((event){
        streamController.sink.add(event.chatMessageList!!);
      });
      return snapshots;
    } catch (ex) {
      log('error: ', error: ex.toString(), stackTrace: StackTrace.current);
      return Stream.error(ex.toString());
    }
  }
}