import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:haemo/model/user_response_model.dart';
import 'package:haemo/service/db_service.dart';
import 'package:haemo/utils/shared_preference.dart';
import 'package:intl/intl.dart';
import '../model/chat_model.dart';

class ChatListController extends GetxController {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  final db = DBService();
  final _chatRef = FirebaseDatabase.instance.ref().child('chat');
  final _userRef = FirebaseDatabase.instance.ref().child('user');

  var fireBaseChatModel = <FireBaseChatModel>[].obs;
  var userChatList = <String>[].obs;
  var _chatList = <String, UserResponse>{}.obs;
  Map<String, UserResponse> get chatList => _chatList;

  late int uId;
  late String myNickname;

  @override
  void onInit() {
    super.onInit();
    uId = 6;
    myNickname = PreferenceUtil.getUser().nickname;
    getChatList();
  }

  Future<void> getLastChatInfo(String chatId) async {
    final orderedChatList = _chatRef
        .child(chatId)
        .child('messages')
        .orderByChild('createdAt')
        .limitToLast(1);

    orderedChatList.once().then((DatabaseEvent event) async {
      final snapshot = event.snapshot;
      if (snapshot.value != null) {
        final lastMessage = Map<String, dynamic>.from(snapshot.value as Map);
        final chatUsers = chatId.split('+');
        var receiverId = 0;
        var senderId = 0;

        if (chatUsers[0] != uId.toString()) {
          receiverId = int.parse(chatUsers[0]);
          senderId = uId;
        } else {
          receiverId = uId;
          senderId = int.parse(chatUsers[1]);
        }

        try {
          final response = await db.getUserById(receiverId);
          if (response != null) {
            final receiverInfo = response;
            chatList[chatId] = receiverInfo;

            final messageData = [
              ChatMessageModel(
                createdAt: lastMessage['createdAt'] as int,
                isRead: lastMessage['read'] as bool? ?? false,
                content: lastMessage['content'] as String,
                from: lastMessage['from'] as int,
                senderNickname: lastMessage['senderNickname'] as String,
              )
            ];

            final chatData = FireBaseChatModel(
              id: chatId,
              sender: ChatUserModel(id: senderId, nickname: myNickname),
              receiver: ChatUserModel(
                  id: receiverId, nickname: receiverInfo?.nickname ?? ''),
              messages: messageData,
            );

            if (!fireBaseChatModel.contains(chatData)) {
              fireBaseChatModel.add(chatData);
            }
          } else {
            print("Failed to get receiver info: ${response.toString}");
          }
        } catch (e) {
          print("Error while getting receiver info: $e");
        }
      } else {
        print("No message found");
      }
    });
  }

  void getChatList() {
    final chatListener = _databaseReference.child('user').child("6");

    chatListener.onValue.listen((event) {
      final userChatListData =
          List<String>.from(event.snapshot.value as List<dynamic>);
      userChatList.assignAll(userChatListData);
      userChatList.forEach(getLastChatInfo);
    });
  }

  String formatDateTime(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final format = DateFormat('HH시 mm분');
    return format.format(date);
  }
}
