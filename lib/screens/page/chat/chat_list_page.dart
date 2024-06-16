import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:haemo/common/user_image.dart';
import 'package:haemo/controller/chat_controller.dart';
import 'package:haemo/model/chat_model.dart';
import 'package:haemo/model/user_response_model.dart';
import 'package:haemo/screens/page/chat/chat_room_page.dart';
import 'package:haemo/service/db_service.dart';
import '../../../common/theme.dart';
import '../../../controller/chatlist_controller.dart';
import '../../../model/chat_message_model.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: const Text("채팅"),
      ),
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
