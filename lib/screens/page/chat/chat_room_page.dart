import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:haemo/controller/chat_controller.dart';
import 'package:haemo/model/user_response_model.dart';
import 'package:haemo/screens/components/customAppBar.dart';
import 'package:haemo/utils/chage_time_format.dart';
import '../../../common/color.dart';
import '../../../model/chat_message_model.dart';
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
      ? PreferenceUtil.getInt("uId").toString()!
      : "sender";
  final int profileImage = PreferenceUtil.getInt("profileImage") != null
      ? PreferenceUtil.getInt("profileImage")!
      : 1;
  final firestore = FirebaseFirestore.instance;

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
              child: Container(child: Text("하")),
            ),
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              color: Colors.white,
              child: chatTextField(_textController, () => _handleSubmitted()),
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

  void _handleSubmitted() {
    // firestore에 저장 후 변경을 보고 가져온 리스트가 자동으로 controller로 추가되게

    if (_textController.text == "") {
      print("hey");
    }
  }
}

Widget receiver(String text, String name, DateTime time, dynamic profile) {
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
              Text(changeDatetimeToString(time),
                  style: const TextStyle(fontSize: 12, color: Colors.black26))
            ],
          )),
        ],
      ),
    ],
  );
}

Widget sender(String text, DateTime time) {
  return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Column(
          children: [
            SizedBox(height: 18),
            Text(changeDatetimeToString(time),
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
