import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hae_mo/controller/chat_controller.dart';
import 'package:hae_mo/utils/chage_time_format.dart';
import '../model/chatlist_model.dart';
import '../model/chatmessage_model.dart';
import '../model/shared_preference.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final TextEditingController _textController = TextEditingController();
  final controller = Get.put(ChatController());

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
      onPressed: () {},
    );
  }

  _handleSubmitted() {
    var text = _textController.text;
    _textController.clear();
    controller.streamController.sink.add([
      ChatMessage(
          text: text,
          sender: PreferenceUtil.getString("studentId")!,
          createdAt: DateTime.now(),
          isRead: false)
    ]);
  }

  Widget chooseSender(ChatMessage chat) {
    // sharedpreference에 저장된 아이디라면
    if (chat.sender == "sender") {
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
              onPressed: () {},
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
                child: SingleChildScrollView(
                    child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  StreamBuilder(
                    stream: controller.streamController.stream,
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        List<ChatMessage> listMessage = snapshot.data;

                        return ListView.builder(
                          itemCount: listMessage.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            if (listMessage[index].sender == "sender") {
                              return sender(listMessage[index].text!,
                                  listMessage[index].createdAt!);
                            } else {
                              return receiver(
                                  listMessage[index].text!,
                                  listMessage[index].sender!,
                                  listMessage[index].createdAt!,
                                  1);
                            }
                          },
                        );
                      } else {
                        return const Center(child: Text("a"));
                      }
                    },
                  ),
                  for (var chat in controller.chatMessageList)
                    chooseSender(chat)

/*                    ListView.builder(
                      itemCount: chats.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        if (chats[index].sender == "sender") {
                          return Sender(chats[index].text!, chats[index].text!);
                        } else {
                          return Receiver(chats[index].text!,
                              chats[index].sender!, chats[index].text!, 1);
                        }
                      },
                    )*/
                ],
              ),
            ))),
            Container(
                height: 60,
                color: Colors.white,
                child: Row(
                  children: [
                    chatIconButton(const Icon(FontAwesomeIcons.squarePlus)),
                    Expanded(
                        child: Container(
                            child: TextField(
                      controller: _textController,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 20),
                      decoration: const InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                      onSubmitted: _handleSubmitted(),
                    ))),
                    chatIconButton(const Icon(FontAwesomeIcons.faceSmile)),
                    chatIconButton(const Icon(FontAwesomeIcons.gear))
                  ],
                ))
          ])),
    ));
  }
}
