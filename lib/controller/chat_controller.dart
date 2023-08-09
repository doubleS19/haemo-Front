import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hae_mo/screens/page/chat_list_page.dart';
import 'package:http/http.dart';

import '../model/chatmessage_model.dart';
import '../utils/shared_preference.dart';

class ChatController extends GetxController {
  final firestore = FirebaseFirestore.instance;
  final RxString _text = "".obs;
  final RxString _sender = "".obs;
  final createdAt = DateTime.now();
  late List<ChatMessage> chatMessageList = [];

  get text => _text;
  get sender => _sender;

  StreamController<List<ChatMessage>> streamController = StreamController<List<ChatMessage>>();

  void startStream(){

  }

  @override
  void onInit() {
    super.onInit();

  }

  /// Firestore doc에 새로운 체탱창 생성
  /// @param ChatUser chatuser receiver의 ChatUser 정보
  /// @param ChatMessage chatMessage sender이 입력한 ChatMessage
  /// @return void
  /// @success - 채팅창 생성 성공
  /// @author: seoyeon
  /// @ 테스트 후 studentId를 sharedPreference에서 가져오도록 변경하기
  void createChatroom(ChatUser otherUser, ChatMessage chatMessage) {
    // me, other 사이에 생성된 채팅방이 있는지 확인 - 게시물에서 채팅으로 넘어갈 때 필요할 듯?
    var chatRoomId = "${PreferenceUtil.getString("studentId") != null ? PreferenceUtil.getString("studentId")! : "seoyeon"}_${otherUser.studentId}";

    var chatroom = ChatData(
      chatRoomId: chatRoomId,
      chatUser1: ChatUser(
/*          studentId:
PreferenceUtil.getString("studentId")!,
          profileImage: PreferenceUtil.getInt("profileImage") != null? PreferenceUtil.getInt("profileImage")! : 1*/
        studentId: "seoyeon",
        profileImage: 1
      ),
      chatUser2: otherUser,
      chatMessageList: [chatMessage]
    );

    firestore.collection('haemo').doc(chatRoomId)
        .set(chatroom.toJson());

  }


  /// 메세지 전송 클릭 시 FireStore로 전송되어 chatMessageList에 저장됨
  /// @param String chatRoomId 고유 채팅방 Id
  /// @param ChatMessage chatMessage 전송할 채팅 메세지
  /// @return void
  /// @success - 채팅창 메세지 저장 성공
  /// @author: seoyeon
  void sendData(String chatRoomId, ChatMessage chatMessage) async{
    try {
      final snapshot = await firestore.collection('haemo').doc(chatRoomId).get();
      print(snapshot.data());

      if(snapshot.exists) {
        final chatData = ChatData.fromDocumentSnapshot(snapshot);
        print("chatData: $chatData");
        final messages = chatData.chatMessageList;
        messages?.add(chatMessage);

        print(messages);

        firestore
            .collection('haemo')
            .doc(chatRoomId)
            .update(
            {'chatMessageList': messages?.map((e) => e.toJson()).toList()});
      }
    } catch (ex) {
      log('error', error: ex.toString());
    }
  }

  /// 메세지 읽었을 때 false -> true


  /// Firestore에서 새로운 메시지 가져오기 - stream
  /// @param String chatRoomId 고유 채팅방 Id
  /// @return Stream<ChatData> (Streambuilder에서 바로 사용)
  /// @notSuccess
  /// @author: seoyeon
  Stream<ChatData> streamChatMessage(String chatRoomId) {
    try {
      // charRoomId가 없으면 조회되지 않음

      final snapshots = firestore
          .collection('haemo')
          .doc(chatRoomId)
          .snapshots()
          .map((event) => ChatData.fromDocumentSnapshot(event));

      return snapshots;
    } catch (ex) {
      log('error: ', error: ex.toString(), stackTrace: StackTrace.current);
      return Stream.error(ex.toString());
    }
  }
}