import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hae_mo/controller/chat_controller.dart';
import 'package:hae_mo/model/user_response_model.dart';
import 'package:hae_mo/screens/components/customAppBar.dart';
import 'package:hae_mo/utils/chage_time_format.dart';
import '../../../utils/shared_preference.dart';

class ChatRoomPage extends StatefulWidget {
  const ChatRoomPage({Key? key, required this.chatRoomId, required this.otherUser}) : super(key: key);

  final String? chatRoomId;
  final UserResponse otherUser;

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final TextEditingController _textController = TextEditingController();
  late ChatController chatController = ChatController();
  final String studentId = PreferenceUtil.getInt("uId") != null
      ? PreferenceUtil.getInt("uId").toString()!
      : "sender";
  final int profileImage = PreferenceUtil.getInt("profileImage") != null
      ? PreferenceUtil.getInt("profileImage")!
      : 1;

  @override
  void initState() {
    super.initState();
    if(widget.chatRoomId !=""){
      chatController.chatRoomId.value = widget.chatRoomId!;
    }
    chatController.uId = PreferenceUtil.getInt("uId")!;
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
  }

/*  Widget chooseSender(ChatMessage chat) {
    // sharedpreference에 저장된 아이디라면
    if (chat.sender == studentId) {
      return sender(chat.text!, chat.createdAt!);
    } else {
      return receiver(chat.text!, chat.sender!, chat.createdAt!, 1);
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Builder(
              builder: (context) =>
                  chatRoomAppbar(widget.otherUser.nickname, context))),
        body: Container(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.8,
                child: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container()
/*                    StreamBuilder(
                      stream: controller.streamChatMessage(widget.chatRoomId),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasData) {
                          ChatData chatData = snapshot.data;
                          List<ChatMessage>? listMessage =
                              chatData.chatMessageList;
                          return ListView.builder(
                            itemCount: listMessage?.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              for (var chat in controller.chatMessageList) {
                                if (chat.sender == studentId) {
                                  return sender(chat.text!, chat.createdAt!);
                                } else {
                                  return receiver(chat.text!, chat.sender!,
                                      chat.createdAt!, 1);
                                }
                              }
                            },
                          );
                        } else {
                          return const Center(child: Text("a"));
                        }
                      },
                    ),*/
                    )),
              ),
              sendTextField()
            ],
          )),
    );
  }

  Widget sendTextField() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.1,
        color: Colors.white,
        child: Row(
          children: [
            chatIconButton(const Icon(FontAwesomeIcons.squarePlus)),
            Expanded(
                child: Container(
                    child: TextFormField(
              /// https://dalgoodori.tistory.com/60
              controller: _textController,
              maxLines: 3,
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