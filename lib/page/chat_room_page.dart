import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../model/chatlist_model.dart';
import '../model/chatmessage_model.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final List<ChatMessage> chatList = [
    ChatMessage(
        text: "text", sender: "sender", createdAt: "createdAt"),
    ChatMessage(
        text: "text", sender: "receiver", createdAt: "createdAt"),
  ];
  final TextEditingController _textController = TextEditingController();

  Widget receiver(String text, String name, String time, dynamic profile) {
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
                Text(time, style: const TextStyle(fontSize: 12, color: Colors.black26))
              ],
            )),
          ],
        ),
      ],
    );
  }

  Widget sender(String text, String time) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Column(
            children: [
              SizedBox(height: 18),
              Text(time,
                  style: TextStyle(fontSize: 12,  color: Colors.black26)),
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

  void _handleSubmitted(text) {
    _textController.clear();

    setState(() {
      chatList.add(
          ChatMessage(
              text: text, sender: "sender", createdAt: "time"
/*          DateFormat("a K:a")
              .format(DateTime.now())
              .replaceAll("AM", "오전")
              .replaceAll("PM", "오후"))*/
          ));
    });
  }

  Widget chooseSender(ChatMessage chat) {
    if (chat.sender == "sender") {
      return sender(chat.text!, chat.text!);
    } else {
      return receiver(chat.text!, chat.sender!, chat.text!, 1);
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
                icon: const Icon(
                  Icons.report_gmailerrorred_rounded,
                  size: 25
                ),
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
                  for (var chat in chatList) chooseSender(chat)

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
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                      onSubmitted: _handleSubmitted,
                    ))),
                    chatIconButton(Icon(FontAwesomeIcons.faceSmile)),
                    chatIconButton(Icon(FontAwesomeIcons.gear))
                  ],
                ))
          ])),
    ));
  }
}
