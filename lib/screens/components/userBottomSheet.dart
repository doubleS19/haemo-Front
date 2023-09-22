import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hae_mo/common/color.dart';
import 'package:hae_mo/controller/chat_controller.dart';
import 'package:hae_mo/model/user_response_model.dart';
import 'package:hae_mo/screens/page/chat/chat_room_page.dart';
import 'package:hae_mo/screens/page/report/reporting_page.dart';

void userBottomSheet(BuildContext context, UserResponse user) {
  ChatController chatController = ChatController();

  showModalBottomSheet<void>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(45.0),
    ),
    builder: (BuildContext context) {
      return Container(
        height: 450,
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            SizedBox(
                width: 97.0,
                height: 127.0,
                child: Image(
                  image: AssetImage(user.userImage),
                )),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              user.nickname,
              style:
                  const TextStyle(fontSize: 24.0, fontWeight: FontWeight.w300),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              user.major,
              style:
                  const TextStyle(fontSize: 11.0, fontWeight: FontWeight.w300),
            ),
            const SizedBox(
              height: 25.0,
            ),
            Container(
                decoration: const BoxDecoration(
                    color: Color(0xfff1f1f1),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                height: 47.0,
                width: double.infinity * 0.9,
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "한 줄 소개",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.black),
                  ),
                )),
            const SizedBox(
              height: 30.0,
            ),
            Row(
              children: [
                Expanded(
                    flex: 3,
                    child: Container(
                      height: 42.0,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20.0)),
                          color: AppTheme.mainColor),
                      child: RawMaterialButton(
                          onPressed: (() async {
                            Get.to(ChatRoomPage(chatRoomId: await chatController.checkChatRoomExistence(user.uId), otherUser: user));
                          }),
                          child: const Text(
                            "채팅하기",
                            style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          )),
                    )),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      height: 42.0,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          color: Color(0xfff65a64)),
                      child: RawMaterialButton(
                          onPressed: (() {
                            Get.to(ReportingPage(nickname: user.nickname));
                          }),
                          child: const Text(
                            "신고하기",
                            style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          )),
                    )),
              ],
            )
          ],
        ),
      );
    },
  );
}
