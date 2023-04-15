import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hae_mo/model/post_response_model.dart';
import 'package:http/http.dart';

import '../controller/posting_controller.dart';
import '../model/post_model.dart';
import '../service/db_service.dart';

class BoardDetailPage extends StatefulWidget {
  const BoardDetailPage({super.key, required this.pId});

  final int pId;

  @override
  State<BoardDetailPage> createState() => _BoardDetailPageState();
}

class _BoardDetailPageState extends State<BoardDetailPage> {
  @override
  Widget build(BuildContext context) {
    DBService db = DBService();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          elevation: 0.0,
          title: const Text(
            "게시물 조회",
            style: TextStyle(
              color: Color(0xff595959),
              fontSize: 19.0,
            ),
          ),
          automaticallyImplyLeading: true,
        ),
        body: Column(children: [
          const Divider(color: Color(0xff3ac7e7)),
          FutureBuilder(
              future: db.getPostById(widget.pId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final Post post = snapshot.data as Post;
                  return Column(
                    children: [
                      Text(
                        post.title,
                        style: const TextStyle(
                            fontSize: 20.0,
                            color: Color(0xff595959),
                            fontWeight: FontWeight.w400),
                      ),
                      Text(post.content)
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("${snapshot.error}"),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              })
        ]));
  }
}
