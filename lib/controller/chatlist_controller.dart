import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hae_mo/model/chat_message_model.dart';
import 'package:hae_mo/model/user_response_model.dart';
import 'package:hae_mo/service/db_service.dart';
import 'package:hae_mo/utils/shared_preference.dart';

import '../screens/Page/chat/chat_list_page.dart';
import '../model/chatlist_model.dart';

class ChatListController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  DBService dbService = DBService();
  List<ChatList> chatList = [];
  StreamController streamController = StreamController();
  late int uId;
  late String nickname;

  @override
  void onInit() {
    super.onInit();
    uId = PreferenceUtil.getInt("uid")!;
    nickname = PreferenceUtil.getString("nickname")!;
  }

  void addChatList() async {
    bool isEnabled = false;

    await firestore.collection("group").where("members", isEqualTo: [43, 47]).where("isDeleted", isEqualTo: true).get().then((value) {
      print("print: ${value.docs}");
      if(value.docs.isEmpty){
        isEnabled = true;
      }
    });

    if(isEnabled){
      await firestore.collection("group").doc().set(ChatList(
          createdAt: DateTime.now(),
          createdBy: "seoyeon",
          id: "id",
          isDeleted: false,
          membersId: [43, 47],
          recentMessage: ChatMessage(
              messageText: "Hi!",
              sentBy: 43,
              sentAt: DateTime.now(),
              isRead: false
          )).toJson());
    }
  }

  void getChatList() async{
      QuerySnapshot<Map<String, dynamic>> _snapshot = await firestore.collection("group").get();
      print("들어온 데이터는? ${_snapshot.docs.map((e) => ChatList.fromJson(e.data())).toList()}");
      chatList = _snapshot.docs.map((e) => ChatList.fromJson(e.data())).toList();

  }

  Future<UserResponse> getUserNicknameById(int uId) async{
    UserResponse user = await dbService.getUserById(uId);
    return user;
  }

  void deleteChatList() {
    /// ui에서만 삭제
  }
}
