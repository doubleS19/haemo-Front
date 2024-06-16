import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:haemo/common/color.dart';
import 'package:haemo/controller/comment_controller.dart';
import 'package:haemo/model/reply_response_model.dart';
import '../../service/db_service.dart';
import 'dart:developer' as dev;

class ReplyWidget extends StatefulWidget {
  const ReplyWidget({super.key, required this.type, required this.cId});
  final int cId;
  final int type;

  @override
  _ReplyWidgetState createState() => _ReplyWidgetState();
}

class _ReplyWidgetState extends State<ReplyWidget> {
  CommentController commentController = CommentController();
  DBService db = DBService();
  Future<List<ReplyResponse>>? commentFuture;

  @override
  void initState() {
    super.initState();
    widget.type == 1
        ? (commentFuture = db.getReplysByCId(widget.cId))
        : (widget.type == 2
            ? (commentFuture = db.getClubReplysByCcId(widget.cId))
            : (commentFuture = db.getHotPlaceReplysByHcId(widget.cId)));
  }

  @override
  Widget build(BuildContext context) {
    commentController.fetchReplyList(widget.cId, widget.type);
    return Obx(() {
      final replyList = commentController.replyList;
      if (replyList.isEmpty) {
        // 댓글이 없는 경우
        return Container();
      } else {
        // 댓글 목록
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
  }
}
