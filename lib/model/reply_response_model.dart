class ReplyResponse {
  final String content;
  final String nickname;
  final String date;
  final int rId;
  final int cId;

  ReplyResponse(
      {required this.content,
      required this.nickname,
      required this.date,
      required this.cId,
      required this.rId});

  factory ReplyResponse.fromJson(Map<String, dynamic> json) {
    return ReplyResponse(
        content: json['content'],
        nickname: json['nickname'],
        date: json['date'],
        cId: json['cid'],
        rId: json['rid']);
  }

  Map<String, dynamic> toJson() => {
        'content': content,
        'nickname': nickname,
        'date': date,
        'cid': cId,
        'rid': rId
      };
}
