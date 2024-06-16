import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../model/chat_model.dart';
import '../utils/shared_preference.dart';

class ChatController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  var fireBaseChatModel = Rxn<FireBaseChatModel>();
  var chatMessages = <ChatMessageModel>[].obs;
  var receiverInfo = Rxn<ChatUserModel>();
  var chatId = "".obs;
  var userChatList = <String>[].obs;
  var receiverChatList = <String>[].obs;
  var uId = 0;

  @override
  void onInit() {
    super.onInit();
    uId = PreferenceUtil.getUser().uId;
    fetchUserChatList();
  }

  void fetchUserChatList() async {
    try {
      DataSnapshot snapshot =
          await _databaseReference.child('user').child(uId.toString()).get();
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
      DocumentSnapshot<Map<String, dynamic>> response =
          await _firestore.collection('users').doc(receiverId.toString()).get();
      if (response.exists) {
        receiverInfo.value = ChatUserModel.fromJson(response.data()!);
        print("미란 receiver: ${receiverInfo.value}");
      } else {
        print("ChatController: Failed to get receiver info");
      }
    } catch (e) {
      print("ChatController: Error while getting receiver info: $e");
    }

    _databaseReference
        .child('chatRooms')
        .child(chatId)
        .get()
        .then((DataSnapshot snapshot) {
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
      }
    }).catchError((error) {
      print("미란 chatRoom: $error");
    });

    _databaseReference
        .child('chatRooms')
        .child(chatId)
        .child('messages')
        .onValue
        .listen((event) {
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

    _databaseReference
        .child('chatRooms')
        .child(chatId)
        .child('messages')
        .update(updateMap)
        .then((_) {
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
      _databaseReference
          .child('chatRooms')
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
    // SharedPreferenceUtil에서 사용자 정보를 가져와 설정합니다.
    final myUserData = PreferenceUtil.getUser();
    final uId = myUserData.uId;
    final nickname = myUserData.nickname;

    final sender = ChatUserModel(id: uId, nickname: nickname);
    print("미란 newChatRoom sender: $sender");

    try {
      if (!userChatList.obs.value.contains(chatId)) {
        final receiverInfoResponse = await _firestore
            .collection('users')
            .doc(receiverId.toString())
            .get();
        final receiver = ChatUserModel(
            id: receiverId, nickname: receiverInfoResponse.data()!['nickname']);

        final fireBaseChatModel = FireBaseChatModel(
          id: chatId,
          sender: sender,
          receiver: receiver,
          messages: message,
        );

        await _databaseReference
            .child('chatRooms')
            .child(chatId)
            .set(fireBaseChatModel.toJson());
        print("미란 chatRoom: 채팅룸 생성 완료");
        getChatRoomInfo(chatId, receiverId);

        userChatList.add(chatId);

        await _databaseReference
            .child('user')
            .child(uId.toString())
            .set(userChatList.obs.value);
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
      DataSnapshot snapshot = await _databaseReference
          .child('user')
          .child(receiverId.toString())
          .get();
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
      await _databaseReference
          .child('user')
          .child(receiverId)
          .set(receiverChatList.obs.value);
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
