enum ReplyType { Post, Club, HotPlace }

class Reply {
  final String nickname;
  final String content;
  final String date;
  final int cId;
  final ReplyType type;

  Reply(
      {required this.nickname,
      required this.content,
      required this.date,
      required this.cId,
      required this.type});

  factory Reply.fromJson(Map<String, dynamic> json, ReplyType type) {
    return Reply(
        nickname: json['nickname'],
        content: json['content'],
        date: json['date'],
        cId: json[type == ReplyType.Post
            ? 'cid'
            : (type == ReplyType.Club ? "ccId" : "hcId")],
        type: type);
  }

  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'content': content,
        'date': date,
        if (type == ReplyType.Post) 'cid': cId,
        if (type == ReplyType.Post) 'ccId': cId,
        if (type == ReplyType.Post) 'hcId': cId,
      };
}
