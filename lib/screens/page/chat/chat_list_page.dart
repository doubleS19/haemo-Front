import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hae_mo/model/user_response_model.dart';
import 'package:hae_mo/service/db_service.dart';
import '../../../controller/chatlist_controller.dart';
import '../../../model/chat_message_model.dart';
import '../../components/userBottomSheet.dart';

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
      body: Container(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height*0.8,
                width: MediaQuery.sizeOf(context).width,
                child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          slidableCard(),
                          const Divider(thickness: 1)
                        ],
                      );
                    }),
              ),
              TextButton(
                  onPressed: () {
                    chatListController.addChatList();
                    print("click addChatList");
                  },
                  child: Text("click to make List"))
            ],
          )),
    );
  }

  UserResponse user = UserResponse(
      uId: 43,
      studentId: "studentId",
      nickname: "nickname",
      major: "major",
      userImage: "rabbit",
      gender: "");

  void doNothing(BuildContext context) {}

  Widget slidableCard() {
    return Container(
        height: 80,
        //width: MediaQuery.of(context).size.width,
        child: Slidable(
              endActionPane: ActionPane(
                extentRatio: 0.3,
                motion: const DrawerMotion(),
                children: [
                  SlidableAction(
                    flex: 1,
                    onPressed: (BuildContext context) => doNothing(context),
                    backgroundColor: Color.fromARGB(196, 172, 49, 38),
                    foregroundColor: Colors.white,
                    icon: Icons.check_rounded,
                    label: 'CHECK',
                  ),
                ],
              ),
              child: chatCard(ChatMessage(
                  messageText: "text",
                  sentBy: 43,
                  sentAt: DateTime.now(),
                  isRead: false)),
            ));
  }

  Widget chatCard(ChatMessage chat) {
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            profileImage(context, user),
            Container(
              width: MediaQuery.sizeOf(context).width*0.7,
              child: ListTile(
                title: Text(user.nickname),
                subtitle: Text(chat.messageText ?? ""),
              ))]);
  }
}


Widget profileImage(BuildContext context, UserResponse user){
  return SizedBox(
      width: 41.0,
      height: 41.0,
      child: RawMaterialButton(
          elevation: 0.0,
          fillColor: Colors.transparent,
          shape: CircleBorder(),
          onPressed: (() {
            userBottomSheet(context, user);
          }),
          child: Container(
            width: 41,
            height: 41,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              image: DecorationImage(
                image: AssetImage(
                    "assets/user/user_dog.png"),
              ),
            ),
          )));
}