import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hae_mo/model/user_response_model.dart';
import 'package:hae_mo/screens/page/chat/chat_room_page.dart';
import '../../../common/theme.dart';
import '../../../controller/chatlist_controller.dart';
import '../../../model/chat_message_model.dart';
import '../../../model/chatroom_model.dart';
import '../../../utils/shared_preference.dart';
import '../../components/customAppBar.dart';
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

    chatListController.uId = PreferenceUtil.getInt("uid")!;
    chatListController.getChatList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Builder(builder: (context) => backButtonAppbar(context, ""))),
      body: Container(
          height: MediaQuery.sizeOf(context).height*0.9,
          width: MediaQuery.sizeOf(context).width,
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Text("채팅목록",
                      style: CustomThemes.chatListTitleTeextStyle)),
              SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.7, // 0.75
                  width: MediaQuery.sizeOf(context).width,
                  child: Obx(()=> chatListController.chatList.isNotEmpty? ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: chatListController.chatList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return slidableCard(chatListController.chatList[index], index);
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                      const Divider(height: 1)):Container()))
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

  Widget slidableCard(ChatRoom chat, int index) {
    return GestureDetector(
        onTap: () {
          Get.to(() => ChatRoomPage(chatRoomId: chat.id, otherUserId: chatListController.getOtherId(chat)));
        },
      child: Container(
          height: 85,
          child: Slidable(
            endActionPane: ActionPane(
              extentRatio: 0.3,
              motion: const DrawerMotion(),
              children: [
                SlidableAction(
                  flex: 1,
                  onPressed: (BuildContext context) {
                    chatListController.deleteChatList(chat.id);
                    chatListController.chatList.removeAt(index);
                  },
                  backgroundColor: Color.fromARGB(196, 172, 49, 38),
                  foregroundColor: Colors.white,
                  icon: Icons.check_rounded,
                  label: 'CHECK',
                ),
              ],
            ),
            child: chatCard(chat.recentMessage),
          ))
    );
  }

  Widget chatCard(ChatMessage chat) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          profileImage(context, user),
          Container(
              height: double.maxFinite,
              width: MediaQuery.sizeOf(context).width * 0.7,
              child: ListTile(
                title: Text(user.nickname),
                subtitle: Text(chat.messageText ?? ""),
              ))
        ]));
  }
}

Widget profileImage(BuildContext context, UserResponse user) {
  return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.15,
      height: MediaQuery.sizeOf(context).width * 0.15,
      child: RawMaterialButton(
          elevation: 0.0,
          fillColor: Colors.transparent,
          shape: CircleBorder(),
          onPressed: (() {
            userBottomSheet(context, user);
          }),
          child: Container(
            width: MediaQuery.sizeOf(context).width * 0.15,
            height: MediaQuery.sizeOf(context).width * 0.15,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              image: DecorationImage(
                image: AssetImage("assets/user/user_dog.png"),
              ),
            ),
          )));
}
