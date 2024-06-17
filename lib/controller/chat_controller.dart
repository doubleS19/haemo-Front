import 'dart:async';
import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:haemo/service/db_service.dart';
import 'package:intl/intl.dart';
import '../model/chat_model.dart';
import '../utils/shared_preference.dart';

class ChatController extends GetxController {
  final _chatRef = FirebaseDatabase.instance.ref().child("chat");
  final _userRef = FirebaseDatabase.instance.ref().child("user");
  final db = DBService();

  var fireBaseChatModel = Rxn<FireBaseChatModel>();
  var chatMessages = <ChatMessageModel>[].obs;
  var receiverInfo = Rxn<ChatUserModel>();
  var chatId = "".obs;
  var userChatList = <String>[].obs;
  var receiverChatList = <String>[].obs;
  var uId = PreferenceUtil.getUser().uId;

  @override
  void onInit() {
    super.onInit();
    uId = PreferenceUtil.getUser().uId;
    fetchUserChatList();
  }

  void fetchUserChatList() async {
    try {
      DataSnapshot snapshot = await _userRef.child(uId.toString()).get();
      if (snapshot.exists) {
        userChatList.value = List<String>.from(snapshot.value as List);
        print("유저 채팅 정보 가져옴: ${userChatList.obs.value}");
      }
    } catch (e) {
      print("Error fetching user chat list: $e");
    }
  }

  Future<void> getChatRoomInfo(String chatId, int receiverId) async {
    try {
      _chatRef.child(chatId).once().then((DatabaseEvent event) async {
        final snapshot = event.snapshot;
        if (snapshot.value != null) {
          final chatRoomData =
              Map<Object?, Object?>.from(snapshot.value as Map);
          print("미란 채팅방 정보: ${chatRoomData.obs.value.toString()}");
          final sender = chatRoomData['sender'] as Map<Object?, Object?>;
          final receiver = chatRoomData['receiver'] as Map<Object?, Object?>;

          fireBaseChatModel.value = FireBaseChatModel(
            id: chatRoomData['id'].toString(),
            sender: ChatUserModel(
                id: sender['id'] as int,
                nickname: sender['nickname'].toString()),
            receiver: ChatUserModel(
                id: receiver['id'] as int,
                nickname: receiver['nickname'].toString()),
            messages: (chatRoomData['messages'] as List)
                .map((msg) =>
                    ChatMessageModel.fromJson(Map<String, dynamic>.from(msg)))
                .toList(),
          );
        } else {
          createNewChatRoom(chatId, receiverId, []);
        }
      });
    } catch (e) {
      print("ChatController: Error while getting receiver info: $e");
    }

    _chatRef.child(chatId).get().then((DataSnapshot snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> result =
            Map<String, dynamic>.from(snapshot.value as Map);
        Map<String, dynamic> sender =
            Map<String, dynamic>.from(result['sender']);
        Map<String, dynamic> receiver =
            Map<String, dynamic>.from(result['receiver']);

        fireBaseChatModel.value = FireBaseChatModel(
          id: result['id'],
          sender: ChatUserModel(id: sender['id'], nickname: sender['nickname']),
          receiver:
              ChatUserModel(id: receiver['id'], nickname: receiver['nickname']),
          messages: (result['messages'] as List)
              .map((msg) =>
                  ChatMessageModel.fromJson(Map<String, dynamic>.from(msg)))
              .toList(),
        );
        print("미란 채팅방 정보: ${fireBaseChatModel.value}");
      }
    }).catchError((error) {
      print("미란 chatRoom: $error");
    });

    _chatRef.child(chatId).child('messages').onValue.listen((event) {
      List<ChatMessageModel> chatMessage = [];
      List<dynamic>? messageData = event.snapshot.value as List?;

      if (messageData != null) {
        for (var message in messageData) {
          chatMessage.add(
              ChatMessageModel.fromJson(Map<String, dynamic>.from(message)));
        }
      }

      chatMessages.value = chatMessage;
      readAllMessages(chatId);
    }, onError: (error) {
      print("미란 chatCancel: loadMessage:onCancelled $error");
    });
  }

  void readAllMessages(String chatId) {
    print("미란 채팅리스트: ${chatMessages.obs.value}");
    final updateMap = <String, dynamic>{};

    for (var message in chatMessages.obs.value) {
      if (!message.isRead && message.from != uId) {
        print("미란 메시지: $message");
        message.isRead = true;
        updateMap["${chatMessages.indexOf(message)}/read"] = true;
      }
    }

    print("미란 채팅 메시지: ${chatMessages.obs.value}");

    _chatRef.child(chatId).child('messages').update(updateMap).then((_) {
      print("미란 채팅 메시지: 메시지 읽음으로 표시 완료");
    }).catchError((exception) {
      print("미란 채팅 메시지: 메시지 읽음으로 표시 실패: $exception");
    });
  }

  Future<void> sendMessage(
      String chatId, int receiverId, ChatMessageModel chatMessageModel) async {
    if (chatMessages.obs.value.isEmpty) {
      chatMessages.value = [chatMessageModel];
      print("미란 sendMessage: 새로운 채팅방 만들 거야");
      createNewChatRoom(chatId, receiverId, chatMessages.obs.value);
    } else {
      chatMessages.add(chatMessageModel);
      _chatRef
          .child(chatId)
          .child('messages')
          .set(chatMessages.obs.value.map((e) => e.toJson()).toList())
          .then((_) {
        print("미란 message: 메시지 전송 됨");
      }).catchError((error) {
        print("미란 message: $error");
      });
    }
  }

  Future<void> createNewChatRoom(
      String chatId, int receiverId, List<ChatMessageModel> message) async {
    final myUserData = PreferenceUtil.getUser();
    final uId = myUserData.uId;
    final nickname = myUserData.nickname;

    final sender = ChatUserModel(id: uId, nickname: nickname);
    print("미란 newChatRoom sender: $sender");

    try {
      if (!userChatList.obs.value.contains(chatId)) {
        final receiverInfoResponse = await db.getUserById(receiverId);
        if (receiverInfoResponse == null) {
          print("미란 chatRoom: 상대방 정보 없음");
          return;
        }
        final receiver = ChatUserModel(
            id: receiverId, nickname: receiverInfoResponse.nickname);

        final fireBaseChatModel = FireBaseChatModel(
          id: chatId,
          sender: sender,
          receiver: receiver,
          messages: message,
        );

        await _chatRef.child(chatId).set(fireBaseChatModel.toJson());
        print("미란 chatRoom: 채팅룸 생성 완료");
        getChatRoomInfo(chatId, receiverId);

        userChatList.add(chatId);

        await _userRef.child(uId.toString()).set(userChatList.obs.value);
        print("미란 UserChatInfo: ${userChatList.obs.value}");
        getChatRoomInfo(chatId, receiverId);

        getUserChatRoomList(receiverId);
        print("미란 상대방: ${receiverChatList.obs.value}");
        setUserChatList(receiverId.toString(), chatId);
        print("미란 상대방 이후: ${receiverChatList.obs.value}");
      }
    } catch (e) {
      print("Error creating new chat room: $e");
    }
  }

  Future<void> getUserChatRoomList(int receiverId) async {
    try {
      DataSnapshot snapshot = await _userRef.child(receiverId.toString()).get();
      if (snapshot.exists) {
        receiverChatList.value = List<String>.from(snapshot.value as List);
        print("유저 채팅 정보 가져옴: ${receiverChatList.obs.value}");
      }
    } catch (e) {
      print("Error fetching user chat room list: $e");
    }
  }

  Future<void> setUserChatList(String receiverId, String chatId) async {
    receiverChatList.add(chatId);
    try {
      await _chatRef.child(receiverId).set(receiverChatList.obs.value);
      print("미란 UserChatInfo: ${receiverChatList.obs.value}");
    } catch (e) {
      print("미란 UserChatInfo: $e");
    }
  }

  String formatDateTime(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final format = DateFormat('HH시 mm분');
    return format.format(date);
  }
}
