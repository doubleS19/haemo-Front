import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hae_mo/model/user_model.dart';
import 'package:hae_mo/model/user_response_model.dart';
import '../model/chat_message_model.dart';
import '../model/chatroom_model.dart';

class ChatController extends GetxController {
  final firestore = FirebaseFirestore.instance;
  //final RxString _text = "".obs;
  final createdAt = DateTime.now();
  late List<ChatMessage> chatMessageList = [];
  late int uId;
  late Rx<String> chatRoomId = "".obs;
  late Rx<int> _otherUserId;

  get otherUser => _otherUserId;

  setOtherUser(int userId){
    _otherUserId.value = userId;
  }
  //get text => _text;

  StreamController<List<ChatMessage>> streamController =
      StreamController<List<ChatMessage>>();

  void startStream() {}

  @override
  void onInit() {
    super.onInit();
  }

  /// 나와 상대의 채팅방이 이미 존재한다면 false, 없다면 true => true이면 채팅방 생성 가능
  /// @param relativeId 상대 uId
  /// return Future<String?>
  /// @author: seoyeon
  Future<String?> checkChatRoomExistence(int otherUserId) async {
    String? chatRoomId = "";

    await firestore.collection("group").where("members", isEqualTo: [uId, otherUserId]).where("isDeleted", isEqualTo: false).get().then((value) {
      print("print: ${value.docs}");
      if(value.docs.isEmpty){
        chatRoomId = "";
      }else{
        chatRoomId = value.docs.map((e) => ChatRoom.fromJson(e.data())).toList()[0].id;
      }
    });
    return chatRoomId;
  }

  /// Firestore doc에 새로운 체탱창 생성
  /// @param String chatRoomId 고유 채팅방 Id
  /// @param ChatMessage chatMessage 전송할 채팅 메세지
  /// @return void
  /// @success - 채팅창 메세지 저장 성공
  /// @author: seoyeon
  Future<void> createChatRoom(int relativeId, ChatMessage firstMessage) async {
    await firestore.collection("group").add({
      "createdAt": DateTime.now(),
      "createdBy": uId,
      "id": null,
      "isDeleted": false,
      "membersId": [uId, _otherUserId.value],
      "recentMessage": firstMessage.toJson(),
    }).then((DocumentReference docRef) {
      docRef.update({"id": docRef.id});
    });
  }

  Future<void> updateLastChatMessage(String chatRoomId, ChatMessage message) async{
    await firestore.collection("group").doc(chatRoomId).update({"recentMessage": message.toJson()});
  }

  /// Firestore doc에 새로운 체탱창 생성
  /// @param ChatUser chatuser: receiver의 ChatUser 정보
  /// @param ChatMessage chatMessage: sender이 입력한 ChatMessage
  /// @return void
  /// @success - 채팅창 생성 성공
  /// @author: seoyeon
  /// @ 테스트 후 studentId를 sharedPreference에서 가져오도록 변경하기
  void sendChatMessage(String chatRoomId, String chatMessageText) {

    var firstChatMessage = ChatMessage(
        isRead: false,
        messageText: chatMessageText,
        sentBy: 47,
        sentAt: Timestamp.fromDate(DateTime.now()));

    firestore.collection('message').doc(chatRoomId).set(firstChatMessage.toJson());
  }


  /// 메세지 전송 클릭 시 FireStore로 전송되어 chatMessageList에 저장됨
  /// @param String chatRoomId 고유 채팅방 Id
  /// @param ChatMessage chatMessage 전송할 채팅 메세지
  /// @return void
  /// @success - 채팅창 메세지 저장 성공
  /// @author: seoyeon
/*  void sendData(String chatRoomId, ChatMessage chatMessage) async {
    try {
      final snapshot =
          await firestore.collection('haemo').doc(chatRoomId).get();
      print(snapshot.data());

      if (snapshot.exists) {
        final chatData = ChatData.fromDocumentSnapshot(snapshot);
        print("chatData: $chatData");
        final messages = chatData.chatMessageList;
        messages?.add(chatMessage);

        print(messages);

        firestore.collection('haemo').doc(chatRoomId).update(
            {'chatMessageList': messages?.map((e) => e.toJson()).toList()});
      }
    } catch (ex) {
      log('error', error: ex.toString());
    }
  }*/

  /// 메세지 읽었을 때 false -> true

  /// Firestore에서 새로운 메시지 가져오기 - stream
  /// @param String chatRoomId 고유 채팅방 Id
  /// @return Stream<ChatData> (Streambuilder에서 바로 사용)
  /// @notSuccess
  /// @author: seoyeon
/*  Stream<ChatData> streamChatMessage(String chatRoomId) {
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
  }*/
}
