import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hae_mo/controller/chat_controller.dart';
import 'package:hae_mo/model/user_response_model.dart';
import 'package:hae_mo/screens/components/customAppBar.dart';
import 'package:hae_mo/utils/chage_time_format.dart';
import '../../../common/color.dart';
import '../../../model/chat_message_model.dart';
import '../../../utils/shared_preference.dart';

class ChatRoomPage extends StatefulWidget {
  const ChatRoomPage(
      {Key? key, required this.chatRoomId, required this.otherUser})
      : super(key: key);

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
  final firestore = FirebaseFirestore.instance;


  @override
  void initState() {
    super.initState();
    if (widget.chatRoomId != "") {
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
    return GestureDetector(
      onTap: (){
        _handleSubmitted();
      },
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: AppTheme.mainColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.send_rounded,
          color: AppTheme.white,
        )
      ),
    );
  }

  _handleSubmitted() {
    // firestore에 저장 후 변경을 보고 가져온 리스트가 자동으로 controller로 추가되게

    if (_textController.text == "") {
      return;
    }
  }

  Widget chooseSender(ChatMessage chat) {
    if (chat.sentBy == studentId) {
      return sender(chat.messageText!, chat.sentAt!.toDate());
    } else {
      return receiver(chat.messageText!, widget.otherUser.nickname,
          chat.sentAt!.toDate(), widget.otherUser.userImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    double appScreenHeight = MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.top + kToolbarHeight)!;

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Builder(
                builder: (context) =>
                    chatRoomAppbar(widget.otherUser.nickname, context))),
        body: Container(
          height: appScreenHeight,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
          Container(
            height: appScreenHeight - 90,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: StreamBuilder(
                  stream: firestore
                      .collection('message')
                      .doc(widget.chatRoomId)
                      .collection('message')
                      .snapshots()
                      .map((querySnapshot) {
                    querySnapshot.docs.forEach((document) {
                      List<ChatMessage> chatMessages = [];

                      final data = document.data() as Map<String, dynamic>;
                      final chatMessage = ChatMessage.fromJson(data);
                      chatMessages.add(chatMessage);
                    });
                  }),
                   builder: (BuildContext context, AsyncSnapshot<Null> snapshot) {
                     if (snapshot.hasData) {
                       List<ChatMessage>? chatListMessage = snapshot.data;
                       return ListView.builder(
                         itemCount: chatListMessage?.length,
                         physics: const NeverScrollableScrollPhysics(),
                         itemBuilder: (BuildContext context, int index) {
                           for (var chat in chatListMessage!) {
                             chooseSender(chat);
                           }
                         },
                       );
                     } else {
                       return Container();
                     }
                },
                )),
          )),
                sendTextField()
          ],
        )));
  }

  Widget sendTextField() {
    return Container(
      height: 80,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        color: Colors.white,
        child: Row(
          children: [
            Container(
              height: 70,
                width: MediaQuery.of(context).size.width*0.5,
                child: TextFormField(
                  /// https://dalgoodori.tistory.com/60
                  controller: _textController,
                  maxLines: 1,
                  cursorColor: Colors.orange,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: AppTheme.chatTextFieldBackgroundColor
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (String value) {
                    _handleSubmitted();
                  },
                )),
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
                      style: const TextStyle(
                          fontSize: 12, color: Colors.black26))
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