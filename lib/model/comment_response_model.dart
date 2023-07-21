class CommentResponse {
  final String content;
  final String nickname;
  final String date;
  final int pId;
  final int cId;

  CommentResponse(
      {required this.content,
      required this.nickname,
      required this.date,
      required this.cId,
      required this.pId});

  factory CommentResponse.fromJson(Map<String, dynamic> json) {
    return CommentResponse(
        content: json['content'],
        nickname: json['nickname'],
        date: json['date'],
        cId: json['deadline'],
        pId: json['pid']);
  }

  Map<String, dynamic> toJson() => {
        'content': content,
        'nickname': nickname,
        'date': date,
        'cid': cId,
        'pid': pId
      };
}
