import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:haemo/model/user_response_model.dart';
import 'package:haemo/service/db_service.dart';
import 'package:haemo/utils/shared_preference.dart';
import 'package:intl/intl.dart';
import '../model/chat_model.dart';

class ChatListController extends GetxController {
  final db = DBService();
  final _chatRef = FirebaseDatabase.instance.ref().child('chat');
  final _userRef = FirebaseDatabase.instance.ref().child('user');

  var fireBaseChatModel = <FireBaseChatModel>[].obs;
  var userChatList = <String>[].obs;
  var _chatList = <String, UserResponse>{}.obs;
  Map<String, UserResponse> get chatList => _chatList;

  late int uId;
  String myNickname = PreferenceUtil.getUser().nickname;

  @override
  void onInit() {
    super.onInit();
    uId = 1;
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
        final lastMessageData =
            Map<String, dynamic>.from(snapshot.value as Map);
        final last = lastMessageData.values.first as Map<Object?, Object?>;
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

        final user = await db.getUserById(senderId);

        _chatList[chatId] = user!;

        final messageData = [
          ChatMessageModel(
            createdAt: last['createdAt'] as int,
            isRead: last['read'] as bool? ?? false,
            content: last['content'] as String,
            from: last['from'] as int,
            senderNickname: last['senderNickname'] as String,
          )
        ];

        final chatData = FireBaseChatModel(
          id: chatId,
          sender: ChatUserModel(id: senderId, nickname: myNickname),
          receiver: ChatUserModel(id: receiverId, nickname: user.nickname),
          messages: messageData,
        );

        if (!fireBaseChatModel.contains(chatData)) {
          fireBaseChatModel.add(chatData);
        }
      } else {
        print("No message found");
      }
    });
  }

  void getChatList() {
    final chatListener = _userRef.child(uId.toString());

    chatListener.once().then((DatabaseEvent event) {
      final userChatListData = event.snapshot.value as List<Object?>;
      userChatList.assignAll(userChatListData.cast<String>());
    }).then((_) {
      userChatList.forEach(getLastChatInfo);
    });
  }

  String formatDateTime(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final format = DateFormat('HH시 mm분');
    return format.format(date);
  }
}
