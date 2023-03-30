import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hae_mo/Page/recommend_page.dart';
import 'package:hae_mo/model/chatlist_model.dart';

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
  List<Chat> chatList = [];

  @override
  void initState() {
    //adding item to list, you can add using json from network
    chatList.add(Chat(nickname: "정왕동 뿡뿡이", message: "Hari Prasad Chaudhary"));
    chatList.add(Chat(nickname: "정직한 정서연", message: "Krishna Karki"));
    chatList.add(Chat(nickname: "귀찮은 송미란", message: "Hari Prasad Chaudhary"));
    chatList.add(Chat(nickname: "ㅎㅎㅅ", message: "Krishna Karki"));
    chatList.add(Chat(nickname: "ㅇㅅㅊ", message: "Hari Prasad Chaudhary"));
    chatList.add(Chat(nickname: "ㅂㅈㅁ", message: "Krishna Karki"));
    chatList.add(Chat(nickname: "ㅅㅇㅅ 렛츠고", message: "Hari Prasad Chaudhary"));
    chatList.add(Chat(nickname: "어리둥절빙글빙글", message: "Krishna Karki"));
    chatList.add(Chat(nickname: "돌아가는", message: "Hari Prasad Chaudhary"));
    chatList.add(Chat(nickname: "쨍구의하루", message: "Krishna Karki"));
    chatList.add(Chat(nickname: "또라에모옹도와죠", message: "Hari Prasad Chaudhary"));
    chatList.add(Chat(nickname: "인천섹시남", message: "Krishna Karki"));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: const Align(
              alignment: Alignment.centerLeft,
              child: Text("헤쳐모여 TUK",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.w800))),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: chatList.map((personone) {
                return Slidable(
                  key: Key(personone.nickname),
                  actionPane: const SlidableDrawerActionPane(),
                  actionExtentRatio: 0.15,
                  secondaryActions: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent),
                      child: const Text("삭제",
                          style:
                              TextStyle(color: Colors.white, fontSize: 13.0)),
                      onPressed: () {
                        chatList.removeWhere((element) {
                          return element.nickname == personone.nickname;
                        }); //go through the loop and match content to delete from list
                        setState(() {});
                      },
                    ),
                  ],
                  child: Card(
                    child: ListTile(
                      title: Text(personone.nickname),
                      subtitle: Text(personone.message),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class Chat {
  String nickname, message;
  Chat({required this.nickname, required this.message});
}
