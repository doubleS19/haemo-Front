import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hae_mo/common/color.dart';

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
        return Column(children: const [
          Text("댓글 0",
              style: TextStyle(
                  color: Color(0xff040404), fontWeight: FontWeight.w500)),
          Center(
            child: Text(
              "댓글이 없어요!",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
            ),
          )
        ]);
      } else {
        // 댓글 목록
        final commentList = snapshot.data!;
        commentList.removeWhere((element) => element.type != type);
        return Column(children: [
          Row(children: [
            const Text("댓글 ",
                style: TextStyle(
                    color: Color(0xff040404), fontWeight: FontWeight.w500)),
            Text(commentList.length.toString(),
                style: const TextStyle(
                    color: Color(0xff040404), fontWeight: FontWeight.w500)),
          ]),
          ListView.builder(
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
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(children: [
                          Container(
                            width: 41,
                            height: 41,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppTheme.mainTextColor,
                              image: const DecorationImage(
                                image: AssetImage('assets/images/sunset.jpg'),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                commentList[index].nickname,
                                style: TextStyle(
                                  color: AppTheme.mainTextColor,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                commentList[index].content,
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: AppTheme.mainTextColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ])),
                  ),
                ],
              );
            },
          )
        ]);
      }
    },
  );
}
