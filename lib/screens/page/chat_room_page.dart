import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hae_mo/controller/chat_controller.dart';
import 'package:hae_mo/utils/chage_time_format.dart';
import '../../model/chatlist_model.dart';
import '../../model/chatmessage_model.dart';
import '../../model/shared_preference.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key, required this.chatRoomId}) : super(key: key);

  final String chatRoomId;

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final TextEditingController _textController = TextEditingController();
  final controller = Get.put(ChatController());
  final String studentId = PreferenceUtil.getString("studentId") != null
      ? PreferenceUtil.getString("studentId")!
      : "sender";
  final int profileImage = PreferenceUtil.getInt("profileImage") != null
      ? PreferenceUtil.getInt("profileImage")!
      : 1;

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

  Widget timeLine(String time) {
    return Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Color(0xFF9cafbe)),
        child: Text(time, style: TextStyle(color: Colors.white)));
  }

  Widget chatIconButton(Icon icon) {
    return IconButton(
      padding: EdgeInsets.symmetric(horizontal: 15),
      icon: icon,
      iconSize: 25,
      onPressed: () {
        _handleSubmitted();
      },
    );
  }

  _handleSubmitted() {
    // firestore에 저장 후 변경을 보고 가져온 리스트가 자동으로 controller로 추가되게

    if (_textController.text == "") {
      return;
    }

    controller.sendData(
        widget.chatRoomId,
        ChatMessage(
            text: _textController.text,
            sender: studentId,
            createdAt: DateTime.now(),
            isRead: false));

    _textController.clear();
  }

  Widget chooseSender(ChatMessage chat) {
    // sharedpreference에 저장된 아이디라면
    if (chat.sender == studentId) {
      return sender(chat.text!, chat.createdAt!);
    } else {
      return receiver(chat.text!, chat.sender!, chat.createdAt!, 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      //color: ,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text("Seoyeon"),
            //style: Theme.of(context).textTheme.headline6
            leading: IconButton(
              icon: const Icon(FontAwesomeIcons.arrowLeft),
              onPressed: () {
                Get.back();
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.report_gmailerrorred_rounded, size: 25),
                onPressed: () {},
              ),
              const SizedBox(width: 8)
            ],
          ),
          body: Column(children: [
            Expanded(
                flex: 3,
                child: SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      // StreamBuilder(
                      //   stream: controller.streamChatMessage(widget.chatRoomId),
                      //   builder: (BuildContext context,
                      //       AsyncSnapshot<dynamic> snapshot) {
                      //     if (snapshot.hasData) {
                      //       ChatData chatData = snapshot.data;
                      //       List<ChatMessage>? listMessage =
                      //           chatData.chatMessageList;
                      //       return ListView.builder(
                      //         itemCount: listMessage?.length,
                      //         physics: const NeverScrollableScrollPhysics(),
                      //         itemBuilder: (BuildContext context, int index) {
                      //           for (var chat in controller.chatMessageList) {
                      //             if (chat.sender == studentId) {
                      //               return sender(chat.text!, chat.createdAt!);
                      //             } else {
                      //               return receiver(chat.text!, chat.sender!,
                      //                   chat.createdAt!, 1);
                      //             }
                      //           }
                      //         },
                      //       );
                      //     } else {
                      //       return const Center(child: Text("a"));
                      //     }
                      //   },
                      // ),
                    ],
                  ),
                ))),
            sendTextField(widget.chatRoomId)
          ])),
    ));
  }

  Widget sendTextField(String chatRoomId) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.7,
        color: Colors.white,
        child: Row(
          children: [
            chatIconButton(const Icon(FontAwesomeIcons.squarePlus)),
            Expanded(
                child: Container(
                    child: TextFormField(
              /// https://dalgoodori.tistory.com/60
              controller: _textController,
              maxLines: 1,
              cursorColor: Colors.orange,
              style: const TextStyle(fontSize: 20),
              decoration: const InputDecoration(
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (String value) {
                _handleSubmitted();
              },
            ))),
            chatIconButton(const Icon(FontAwesomeIcons.faceSmile)),
            chatIconButton(const Icon(FontAwesomeIcons.gear))
          ],
        ));
  }
}
