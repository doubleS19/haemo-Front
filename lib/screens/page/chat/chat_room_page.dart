import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:haemo/common/user_image.dart';
import 'package:haemo/controller/chat_controller.dart';
import 'package:haemo/model/chat_model.dart';
import 'package:haemo/model/user_response_model.dart';
import 'package:haemo/screens/components/customAppBar.dart';
import 'package:haemo/utils/chage_time_format.dart';
import '../../../common/color.dart';
import '../../../utils/shared_preference.dart';
import '../../components/customTextField.dart';

class ChatRoomPage extends StatefulWidget {
  const ChatRoomPage(
      {Key? key, required this.chatRoomId, required this.otherUser})
      : super(key: key);

  final String? chatRoomId;
  final UserResponse otherUser;

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final TextEditingController _textController = TextEditingController();
  late ChatController chatController = ChatController();
  final String studentId = PreferenceUtil.getInt("uId") != null
      ? PreferenceUtil.getInt("uId").toString()
      : "sender";
  final int profileImage = PreferenceUtil.getInt("profileImage") != null
      ? PreferenceUtil.getInt("profileImage")!
      : 1;
  final firestore = FirebaseFirestore.instance;
  List<ChatMessageModel> messages = [];

  @override
  void initState() {
    super.initState();
    if (widget.chatRoomId != "") {
      chatController.chatId.value = widget.chatRoomId!;
      chatController.getChatRoomInfo(
          chatController.chatId.value, widget.otherUser.uId);
      messages = chatController.chatMessages.obs.value;
    }
    chatController.uId = PreferenceUtil.getInt("uId")!;
  }

  @override
  Widget build(BuildContext context) {
    double appScreenHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top + kToolbarHeight);

    chatController.getChatRoomInfo(widget.chatRoomId!, widget.otherUser.uId);
    messages = chatController.chatMessages.obs.value;

    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Builder(
                builder: (context) =>
                    chatRoomAppbar(widget.otherUser.nickname, context))),
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Obx(
              () => Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: chatInfo(messages, widget.otherUser.uId),
                  ),
                  Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    color: Colors.white,
                    child: chatTextField(_textController, () {
                      ChatMessageModel newChat = ChatMessageModel(
                          content: _textController.text,
                          createdAt: DateTime.now().millisecondsSinceEpoch,
                          from: chatController.uId,
                          senderNickname: "뜽미니에요");
                      chatController.sendMessage(chatController.chatId.value,
                          widget.otherUser.uId, newChat);
                      _textController.clear();
                      setState(() {});
                    }),
                  ),
                ],
              ),
            )));
  }

  Widget timeLine(String time) {
    return Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color(0xFF9cafbe)),
        child: Text(time, style: const TextStyle(color: Colors.white)));
  }

  Widget chatInfo(List<ChatMessageModel> messages, int receiverId) {
    print("미란 메시지는용: ${messages.toString()}");
    final ScrollController _scrollController = ScrollController();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
    return ListView.builder(
        controller: _scrollController,
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return messages[index].from == receiverId
              ? receiver(messages[index].content, widget.otherUser,
                  messages[index].createdAt)
              : sender(messages[index].content, messages[index].createdAt);
        });
  }
}

Widget receiver(String text, UserResponse receiverUser, int time) {
  return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                child: Image(
                    image: AssetImage(userRoundImage[receiverUser.userImage])),
              ),
              const SizedBox(width: 5),
              Flexible(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(receiverUser.nickname),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        color: AppTheme.chatTextFieldBackgroundColor),
                    child: Text(text, style: const TextStyle(fontSize: 12)),
                  )
                ],
              )),
              const SizedBox(width: 5),
              Flexible(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 22),
                  Text(changeIntToString(time),
                      style:
                          const TextStyle(fontSize: 12, color: Colors.black26))
                ],
              )),
            ],
          ),
        ],
      ));
}

Widget sender(String text, int time) {
  return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 15, 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Column(
          children: [
            const SizedBox(height: 18),
            Text(changeIntToString(time),
                style: const TextStyle(fontSize: 12, color: Colors.black26)),
          ],
        ),
        const SizedBox(width: 5),
        Flexible(
            child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              color: AppTheme.mainColor.withOpacity(0.3)),
          child: Text(text, style: const TextStyle(fontSize: 12)),
        ))
      ]));
}
