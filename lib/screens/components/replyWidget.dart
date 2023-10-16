import 'package:flutter/material.dart';
import 'package:hae_mo/common/color.dart';
import 'package:hae_mo/model/club_reply_response_model.dart';
import 'package:hae_mo/model/hotplace_reply_response_model.dart';
import 'package:hae_mo/model/reply_response_model.dart';
import '../../service/db_service.dart';
import 'dart:developer' as dev;

Widget replyWidget(int cId, int type) {
  DBService db = DBService();
  Future<List<ReplyResponse>>? replyFuture;

  if (type == 1) {
    replyFuture = db.getReplysByCId(cId);
  } else if (type == 2) {
    replyFuture = db.getClubReplysByCcId(cId);
  } else {
    replyFuture = db.getHotPlaceReplysByHcId(cId);
  }

  // if (type == 1) {
  return FutureBuilder<List<ReplyResponse>>(
      future: replyFuture,
      builder: (context, snapshot) {
        print(snapshot.data);
        if (snapshot.connectionState == ConnectionState.waiting) {
          // 데이터 로딩
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          dev.log(snapshot.error.toString());
          // 오류
          return const Center(
            child: Text("댓글을 불러오는 중 오류가 발생했습니다."),
          );
        } else if (snapshot.hasData && snapshot.data!.isEmpty) {
          // 댓글이 없는 경우 빈 컨테이너 반환
          return Container();
        } else {
          // 댓글 목록
          final replyList = snapshot.data!;
          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: replyList.length,
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
                            const SizedBox(width: 20.0),
                            SizedBox(
                              width: 15.0,
                              height: 15.0,
                              child: Image.asset("assets/icons/reply_icon.png"),
                            ),
                            const SizedBox(width: 10.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  replyList[index].nickname,
                                  style: TextStyle(
                                    color: AppTheme.mainTextColor,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        replyList[index].content,
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: AppTheme.mainTextColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(width: 5.0),
                                      // Align(alignment: Alignment., child:
                                      Text(
                                        replyList[index].date,

                                        style: TextStyle(
                                            fontSize: 8.0,
                                            color: AppTheme.mainTextColor),
                                        // )
                                      )
                                    ])
                              ],
                            ),
                          ])),
                    ),
                  ],
                );
              });
        }
      });
  // } else if (type == 2) {
  //   return FutureBuilder<List<ClubReplyResponse>>(
  //     future: db.getClubReplysByCcId(cId),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         // 데이터 로딩
  //         return const Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       } else if (snapshot.hasError) {
  //         // 오류
  //         return const Center(
  //           child: Text("댓글을 불러오는 중 오류가 발생했습니다."),
  //         );
  //       } else if (snapshot.hasData && snapshot.data!.isEmpty) {
  //         // 댓글이 없는 경우
  //         return Container();
  //       } else {
  //         // 댓글 목록
  //         final replyList = snapshot.data!;
  //         return ListView.builder(
  //             shrinkWrap: true,
  //             physics: const NeverScrollableScrollPhysics(),
  //             itemCount: replyList.length,
  //             itemBuilder: (BuildContext context, int index) {
  //               return Column(
  //                 children: [
  //                   Container(
  //                     height: 50.0,
  //                     width: double.infinity,
  //                     margin: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
  //                     child: Align(
  //                         alignment: Alignment.centerLeft,
  //                         child: Row(children: [
  //                           const SizedBox(width: 20.0),
  //                           SizedBox(
  //                             width: 15.0,
  //                             height: 15.0,
  //                             child: Image.asset("assets/icons/reply_icon.png"),
  //                           ),
  //                           const SizedBox(width: 10.0),
  //                           Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             mainAxisAlignment: MainAxisAlignment.center,
  //                             children: [
  //                               Text(
  //                                 replyList[index].nickname,
  //                                 style: TextStyle(
  //                                   color: AppTheme.mainTextColor,
  //                                   fontSize: 12.0,
  //                                   fontWeight: FontWeight.w600,
  //                                 ),
  //                               ),
  //                               Row(
  //                                   crossAxisAlignment: CrossAxisAlignment.end,
  //                                   children: [
  //                                     Text(
  //                                       replyList[index].content,
  //                                       style: TextStyle(
  //                                           fontSize: 12.0,
  //                                           color: AppTheme.mainTextColor,
  //                                           fontWeight: FontWeight.w500),
  //                                     ),
  //                                     const SizedBox(width: 5.0),
  //                                     // Align(alignment: Alignment., child:
  //                                     Text(
  //                                       replyList[index].date,
  //                                       style: TextStyle(
  //                                           fontSize: 6.0,
  //                                           color: AppTheme.mainTextColor),
  //                                       // )
  //                                     )
  //                                   ])
  //                             ],
  //                           ),
  //                         ])),
  //                   ),
  //                 ],
  //               );
  //             });
  //       }
  //     },
  //   );
  // } else {
  //   return FutureBuilder<List<HotPlaceReplyResponse>>(
  //     future: db.getHotPlaceReplysByHcId(cId),
  //     builder: (context, snapshot) {
  //       print(snapshot.data);
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         // 데이터 로딩
  //         return const Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       } else if (snapshot.hasError) {
  //         // 오류
  //         return const Center(
  //           child: Text("댓글을 불러오는 중 오류가 발생했습니다."),
  //         );
  //       } else if (snapshot.hasData && snapshot.data!.isEmpty) {
  //         // 댓글이 없는 경우
  //         return Container();
  //       } else {
  //         // 댓글 목록
  //         final replyList = snapshot.data!;
  //         return ListView.builder(
  //             shrinkWrap: true,
  //             physics: const NeverScrollableScrollPhysics(),
  //             itemCount: replyList.length,
  //             itemBuilder: (BuildContext context, int index) {
  //               return Column(
  //                 children: [
  //                   Container(
  //                     height: 50.0,
  //                     width: double.infinity,
  //                     margin: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
  //                     child: Align(
  //                         alignment: Alignment.centerLeft,
  //                         child: Row(children: [
  //                           const SizedBox(width: 20.0),
  //                           SizedBox(
  //                             width: 15.0,
  //                             height: 15.0,
  //                             child: Image.asset("assets/icons/reply_icon.png"),
  //                           ),
  //                           const SizedBox(width: 10.0),
  //                           Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             mainAxisAlignment: MainAxisAlignment.center,
  //                             children: [
  //                               Text(
  //                                 replyList[index].nickname,
  //                                 style: TextStyle(
  //                                   color: AppTheme.mainTextColor,
  //                                   fontSize: 12.0,
  //                                   fontWeight: FontWeight.w600,
  //                                 ),
  //                               ),
  //                               Row(
  //                                   crossAxisAlignment: CrossAxisAlignment.end,
  //                                   children: [
  //                                     Text(
  //                                       replyList[index].content,
  //                                       style: TextStyle(
  //                                           fontSize: 12.0,
  //                                           color: AppTheme.mainTextColor,
  //                                           fontWeight: FontWeight.w500),
  //                                     ),
  //                                     const SizedBox(width: 5.0),
  //                                     // Align(alignment: Alignment., child:
  //                                     Text(
  //                                       replyList[index].date,
  //                                       style: TextStyle(
  //                                           fontSize: 6.0,
  //                                           color: AppTheme.mainTextColor),
  //                                       // )
  //                                     )
  //                                   ])
  //                             ],
  //                           ),
  //                         ])),
  //                   ),
  //                 ],
  //               );
  //             });
  //       }
  //     },
  //   );
  // }
}
