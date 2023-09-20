import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
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
  RxList chatList = [].obs;
  StreamController streamController = StreamController();
  late int uId;
  late String nickname;

  @override
  void onInit() {
    super.onInit();
    nickname = PreferenceUtil.getString("nickname")!;
  }

  void addChatList(int relativeId, ChatMessage firstMessage) async {
    bool isEnabled = false;

    await firestore.collection("group").where("members", isEqualTo: [uId, relativeId]).where("isDeleted", isEqualTo: false).get().then((value) {
      print("print: ${value.docs}");
      if(value.docs.isEmpty){
        isEnabled = true;
      }
    });

    if(isEnabled){
      await firestore.collection("group").add({
        "createdAt": DateTime.now(),
        "createdBy": uId,
        "id": null,
        "isDeleted": false,
        "membersId": [uId, relativeId],
        "recentMessage": firstMessage.toJson(),
      }).then((DocumentReference docRef) {
        docRef.update({"id": docRef.id});
      });
    }
  }

  void getChatList() async{
      print("uid: $uId");
      QuerySnapshot<Map<String, dynamic>> _snapshot = await firestore.collection("group").where("membersId",arrayContains: uId).where("isDeleted", isEqualTo: false).get();
      print("들어온 데이터는? ${_snapshot.docs.map((e) => ChatList.fromJson(e.data())).toList()}");
      chatList.value = _snapshot.docs.map((e) => ChatList.fromJson(e.data())).toList();

  }

  Future<UserResponse> getUserNicknameById(int uId) async{
    UserResponse user = await dbService.getUserById(uId);
    return user;
  }

  void deleteChatList(String chatId) {
    firestore.collection("group").doc(chatId).update({"isDeleted":true});

  }
}
