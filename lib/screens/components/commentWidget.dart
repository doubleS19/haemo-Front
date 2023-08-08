import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/comment_response_model.dart';
import '../../service/db_service.dart';

Widget commentWidget(int pId, int type) {
  DBService db = DBService();
  return FutureBuilder<List<CommentResponse>>(
    future: db.getCommentsByPId(pId),
    builder: (context, snapshot) {
      print(snapshot.data);
      if (snapshot.connectionState == ConnectionState.waiting) {
        // 데이터 로딩
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (snapshot.hasError) {
        // 오류
        return const Center(
          child: Text("댓글을 불러오는 중 오류가 발생했습니다."),
        );
      } else if (snapshot.hasData && snapshot.data!.isEmpty) {
        // 댓글이 없는 경우
        return const Center(
          child: Text(
            "댓글이 없어요!",
            style: TextStyle(
              fontWeight: FontWeight.w300,
              color: Colors.black,
            ),
          ),
        );
      } else {
        // 댓글 목록
        final commentList = snapshot.data!;
        commentList.removeWhere((element) => element.type != type);
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: commentList.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Container(
                  height: 50.0,
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Text(
                          commentList[index].nickname,
                          style: const TextStyle(
                            color: Color(0xff999999),
                            fontSize: 12.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          commentList[index].content,
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(thickness: 1.0, color: Colors.black),
              ],
            );
          },
        );
      }
    },
  );
}
