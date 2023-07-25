class CommentResponse {
  final String content;
  final String nickname;
  final String date;
  final int pId;
  final int cId;
  final int type;

  CommentResponse(
      {required this.content,
      required this.nickname,
      required this.date,
      required this.cId,
      required this.pId,
      required this.type});

  factory CommentResponse.fromJson(Map<String, dynamic> json) {
    return CommentResponse(
        content: json['content'],
        nickname: json['nickname'],
        date: json['date'],
        cId: json['cid'],
        pId: json['pid'],
        type: json['type']);
  }

  Map<String, dynamic> toJson() => {
        'content': content,
        'nickname': nickname,
        'date': date,
        'cid': cId,
        'pid': pId,
        'type': type
      };
}
