import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haemo/common/user_image.dart';
import 'package:haemo/model/chat_model.dart';
import 'package:haemo/screens/components/customAppBar.dart';
import 'package:haemo/screens/page/chat/chat_room_page.dart';
import '../../../controller/chatlist_controller.dart';
import '../../../utils/shared_preference.dart';
import '../../components/userBottomSheet.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  ChatListController chatListController = ChatListController();
  List<FireBaseChatModel> fireBaseChatModel = <FireBaseChatModel>[];
  @override
  void initState() {
    super.initState();

    chatListController.uId = PreferenceUtil.getInt("uId")!;
    chatListController.getChatList();
  }

  @override
  Widget build(BuildContext context) {
    chatListController.getChatList();
    fireBaseChatModel = chatListController.fireBaseChatModel.obs.value;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child:
              Builder(builder: (context) => customColorAppbar(context, "채팅"))),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: chatListController.chatList.length,
                itemBuilder: (context, index) {
                  final chatId =
                      chatListController.chatList.keys.elementAt(index);
                  final user =
                      chatListController.chatList.values.elementAt(index);
                  return ListTile(
                      onTap: () {
                        Get.to(() => ChatRoomPage(
                              chatRoomId: chatId,
                              otherUser: user,
                            ));
                      },
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage(userRoundImage[user.userImage]),
                      ),
                      title: Text(user.nickname),
                      subtitle: Text(chatListController
                          .fireBaseChatModel[index].messages.last.content),
                      trailing: IconButton(
                        icon: const Icon(Icons.more_vert),
                        onPressed: () {
                          userBottomSheet(context, user);
                        },
                      ));
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
