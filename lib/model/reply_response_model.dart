import 'package:hae_mo/model/reply_model.dart';

enum ReplyType { Post, Club, HotPlace }

class ReplyResponse {
  final String content;
  final String nickname;
  final String date;
  final int rId;
  final int cId;
  final ReplyType type;

  ReplyResponse(
      {required this.content,
      required this.nickname,
      required this.date,
      required this.cId,
      required this.rId,
      required this.type});

  factory ReplyResponse.fromJson(Map<String, dynamic> json, ReplyType type) {
    return ReplyResponse(
        content: json['content'],
        nickname: json['nickname'],
        date: json['date'],
        cId: json[type == ReplyType.Post
            ? 'cid'
            : (type == ReplyType.Club ? 'ccId' : 'hcId')],
        rId: json[type == ReplyType.Post
            ? 'rid'
            : (type == ReplyType.Club ? 'crId' : 'hrId')],
        type: type);
  }

  Map<String, dynamic> toJson() => {
        'content': content,
        'nickname': nickname,
        'date': date,
        if (type == ReplyType.Post) 'cid': cId,
        if (type == ReplyType.Post) 'rid': rId,
        if (type == ReplyType.Club) 'ccId': cId,
        if (type == ReplyType.Club) 'crId': rId,
        if (type == ReplyType.Post) 'hcId': cId,
        if (type == ReplyType.Post) 'hrId': cId,
      };
}
