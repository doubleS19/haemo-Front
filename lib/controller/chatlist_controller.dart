import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hae_mo/model/chat_message_model.dart';

import '../screens/Page/chat/chat_list_page.dart';
import '../model/chatlist_model.dart';

class ChatListController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<ChatList> chatList = [];
  StreamController streamController = StreamController();

  @override
  void onInit() {
    super.onInit();
  }

  void addChatList() async {
    await firestore.collection("group").doc().set(ChatList(
        createdAt: DateTime.now(),
        createdBy: "seoyeon",
        id: "id",
        isDeleted: false,
        members: ["seoyeon", "miran"],
        recentMessage: ChatMessage(
          messageText: "Hi!",
          sentBy: "seoyeon",
          sentAt: DateTime.now(),
          isRead: false
        )).toJson());
  }

  void getChatList() async{
    QuerySnapshot<Map<String, dynamic>> _snapshot = await firestore.collection("group").get();
    print("들어온 데이터는? ${_snapshot.docs.map((e) => ChatList.fromJson(e.data())).toList()}");
    chatList = _snapshot.docs.map((e) => ChatList.fromJson(e.data())).toList();
  }

  void deleteChatList() {
    /// ui에서만 삭제
  }
}
