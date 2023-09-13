import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hae_mo/model/chatlist_model.dart';
import '../../../controller/chatlist_controller.dart';
import '../../../model/chat_message_model.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  ChatListController chatListController = ChatListController();

  @override
  void initState() {
    super.initState();
    chatListController.getChatList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Align(
            alignment: Alignment.centerLeft,
            child: Text("채팅리스트",
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.w800))),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body:
          Container(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  height: 500,
                  width: MediaQuery.sizeOf(context).width,
                  child: ListView.builder(
                    itemCount: chatListController.chatList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          child: Slidable(
                            endActionPane: ActionPane(
                              extentRatio: 0.3,
                              motion: const DrawerMotion(), // 스와이프 애니메이션..
                              children: [
                                SlidableAction(
                                  flex: 1,
                                  // 여러 액션이 있을때 차지하는 비율
                                  onPressed: (BuildContext context) => doNothing(context),
                                  backgroundColor: Color.fromARGB(196, 172, 49, 38),
                                  foregroundColor: Colors.white,
                                  icon: Icons.check_rounded,
                                  label: 'CHECK',
                                ),
                              ],
                            ),
                            child: chatCard(chatListController.chatList[index].recentMessage),
                          )
                      );
                    }
                  ),
                ),
                TextButton(
                    onPressed: () {
                      chatListController.addChatList();
                      print("click addChatList");
                    },
                    child: Text("click to make List"))
              ],
            )
          ),
    );
  }
  void doNothing(BuildContext context) {}
}
Widget chatCard(ChatMessage chat) {
  return Container(
    child: ListTile(
      title: Text(chat.sentBy),
      subtitle: Text(chat.messageText ?? ""),
    ),
  );
}