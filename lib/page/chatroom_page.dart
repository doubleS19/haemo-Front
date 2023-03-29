import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  Widget Receiver() {
    return Column(
      children: [
        Row(
          children: [
            Image.asset("assets/image.png"),
            Column(
              children: const [
                Text("닉네임", style: TextStyle(

                ),),
                SizedBox(height: 20)
              ],
            ),
          ],
        ),
        Text("안녕하세요 메세지")
      ],
    );
  }

  Widget Sender(){
    return Column(
      children: [
        Text("안녕하세요 응답")
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          //color: ,
          child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                title: Text("Seoyeon"),
                //style: Theme.of(context).textTheme.headline6
                actions: [
                  IconButton(
                    icon: const Icon(
                        Icons.report_gmailerrorred_rounded, size: 20),
                    onPressed: () {

                    },
                  ),
                  const SizedBox(width: 25)
                ],
              ),
              body: Column(
                children:[
                  Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          children: [
                            Text("2021년 2월 23일 금요일")
                          ],
                        )
                      )
                  ),
                  Row(
                    children: [
                      TextField(

                      ),
                      Icon(Icons.send)

                    ],
                  )
                ]
              )
          ),
        )

    );
  }

}
