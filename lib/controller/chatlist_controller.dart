import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hae_mo/model/user_response_model.dart';
import 'package:hae_mo/service/db_service.dart';
import 'package:hae_mo/utils/shared_preference.dart';
import '../model/chatroom_model.dart';

class ChatListController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  DBService dbService = DBService();
  RxList chatList = [].obs;
  StreamController streamController = StreamController();
  late int uId;

  void getChatList() async {
    print("uid: $uId");
    QuerySnapshot<Map<String, dynamic>> _snapshot = await firestore
        .collection("group")
        .where("membersId", arrayContains: uId)
        .where("isDeleted", isEqualTo: false)
        .get();
    print(
        "들어온 데이터는? ${_snapshot.docs.map((e) => ChatRoom.fromJson(e.data())).toList()}");
    chatList.value =
        _snapshot.docs.map((e) => ChatRoom.fromJson(e.data())).toList();
  }

  Future<UserResponse> getOtherUserInfo(ChatRoom chatRoomData) async {
    int otherUid;
    if (uId == chatRoomData.membersId[0]) {
      otherUid = chatRoomData.membersId[1];
    }
    otherUid = chatRoomData.membersId[0];
    return await dbService.getUserById(otherUid);
  }

  void deleteChatList(String chatId) {
    firestore.collection("group").doc(chatId).update({"isDeleted": true});
  }
}
