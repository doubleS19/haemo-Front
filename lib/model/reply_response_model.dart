import 'package:hae_mo/model/reply_model.dart';

enum ReplyResponseType { Post, Club, HotPlace }

class ReplyResponse {
  final String content;
  final String nickname;
  final String date;
  final int rId;
  final int cId;
  final ReplyResponseType type;

  ReplyResponse(
      {required this.content,
      required this.nickname,
      required this.date,
      required this.cId,
      required this.rId,
      required this.type});

  factory ReplyResponse.fromJson(
      Map<String, dynamic> json, ReplyResponseType type) {
    return ReplyResponse(
        content: json['content'],
        nickname: json['nickname'],
        date: json['date'],
        cId: json[type == ReplyResponseType.Post
            ? 'cid'
            : (type == ReplyResponseType.Club ? 'ccId' : 'hcId')],
        rId: json[type == ReplyResponseType.Post
            ? 'rid'
            : (type == ReplyResponseType.Club ? 'crId' : 'hrId')],
        type: type);
  }

  Map<String, dynamic> toJson() => {
        'content': content,
        'nickname': nickname,
        'date': date,
        if (type == ReplyResponseType.Post) 'cid': cId,
        if (type == ReplyResponseType.Post) 'rid': rId,
        if (type == ReplyResponseType.Club) 'ccId': cId,
        if (type == ReplyResponseType.Club) 'crId': rId,
        if (type == ReplyResponseType.Post) 'hcId': cId,
        if (type == ReplyResponseType.Post) 'hrId': rId,
      };
}
