import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hae_mo/Page/recommend_page.dart';
import 'package:hae_mo/model/chatlist_model.dart';

import '../controller/chatlist_controller.dart';
import 'club_page.dart';
import 'meeting_page.dart';
import 'my_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '헤쳐모여 TUK',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ChatListPage(),
    );
  }
}

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  ChatListController controller = ChatListController();

  @override
  void initState() {
    //adding item to list, you can add using json from network

    super.initState();
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
        body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(10),
              child: StreamBuilder(
                  stream: controller.streamController.stream,
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data.hashCode,
                          itemBuilder: (context, index) {
                            return Column(
                              children: controller.chatList.map((snapshot) {
                                return slidableCard(snapshot);
                              }).toList(),
                            );
                          });
                    } else {
                      return Column(
                        children: [Text("data")],
                      );
                    }
                  })),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}

Widget slidableCard(ChatList chat) {
  return Slidable(
    key: Key(chat.chatRoomId!!),
    actionPane: const SlidableDrawerActionPane(),
    actionExtentRatio: 0.15,
    secondaryActions: [
      Container(
          margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
          height: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: const Text("삭제",
                style: TextStyle(color: Colors.white, fontSize: 13.0)),
            onPressed: () {
              // chat.removeWhere((element) {
              //   return element.nickname == personone.nickname;
              // });
            },
          )),
    ],
    child: Card(
      child: ListTile(
        title: Text("chat.nickname"),
        subtitle: Text(chat.lastChat != null ? chat.lastChat! : ""),
      ),
    ),
  );
}

class Chat {
  String nickname, message;

  Chat({required this.nickname, required this.message});
}
