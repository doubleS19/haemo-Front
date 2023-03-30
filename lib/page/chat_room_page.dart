import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  Widget Receiver(String text, String name, String time, dynamic profile) {
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
                    child: Text(text),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: Colors.white
                    ),
                  )
                ],
              )
            ),
            const SizedBox(
              width: 5
            ),
            Text(time, style: const TextStyle(fontSize: 12))
          ],
        ),
      ],
    );
  }

  Widget Sender(String text, String time){

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(time, style: TextStyle(fontSize: 20)),
          SizedBox(width:5),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: Color(0xFFfeec34)
              ),
              child: Text(text),
            )
          )
        ]
      )

    );
  }

  Widget TimeLine(String time){
    return Container(
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xFF9cafbe)
      ),
      child: Text(
        time,
        style: TextStyle(color: Colors.white)
      )
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
                        Icons.report_gmailerrorred_rounded, size: 23,),
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            children: [
                              TimeLine("2023년 2월 3일 수요일"),
                              Receiver("안녕", "민수", "오전 10:00", 1),
                              Sender("안녕", "오전 10:00")
                            ],
                          ),
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
