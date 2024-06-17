import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    }
    chatController.uId = PreferenceUtil.getInt("uId")!;
  }

  @override
  Widget build(BuildContext context) {
    double appScreenHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top + kToolbarHeight)!;

    chatController.getChatRoomInfo(widget.chatRoomId!, widget.otherUser.uId);
    messages = chatController.chatMessages ?? [];

    return Scaffold(
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
        child: Column(
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
                print("미란 보낼 채팅 정보: ${newChat.toString()}");
                chatController.sendMessage(
                    chatController.chatId.value, widget.otherUser.uId, newChat);
                _textController.clear();
                setState(() {});
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget timeLine(String time) {
    return Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Color(0xFF9cafbe)),
        child: Text(time, style: TextStyle(color: Colors.white)));
  }
}

Widget chatInfo(List<ChatMessageModel> messages, int receiverId) {
  print("미란 메시지는용: ${messages.toString()}");
  return Column(
    children: [
      for (var message in messages)
        message.from == receiverId
            ? receiver(
                message.content, message.senderNickname, message.createdAt)
            : sender(message.content, message.createdAt)
    ],
  );
}

Widget receiver(String text, String name, int time) {
  return Column(
    children: [
      Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.amberAccent,
          ),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name),
              Container(
                child: Text(text, style: TextStyle(fontSize: 20)),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: Colors.white),
              )
            ],
          )),
          const SizedBox(width: 5),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 22),
              Text(changeIntToString(time),
                  style: const TextStyle(fontSize: 12, color: Colors.black26))
            ],
          )),
        ],
      ),
    ],
  );
}

Widget sender(String text, int time) {
  return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Column(
          children: [
            SizedBox(height: 18),
            Text(changeIntToString(time),
                style: TextStyle(fontSize: 12, color: Colors.black26)),
          ],
        ),
        SizedBox(width: 5),
        Flexible(
            child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              color: Color(0xFFfeec34)),
          child: Text(text, style: TextStyle(fontSize: 20)),
        ))
      ]));
}
