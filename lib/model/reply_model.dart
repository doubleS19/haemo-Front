class Reply {
  final String nickname;
  final String content;
  final String date;
  final int cId;

  Reply(
      {required this.nickname,
      required this.content,
      required this.date,
      required this.cId});

  factory Reply.fromJson(Map<String, dynamic> json) {
    return Reply(
        nickname: json['nickname'],
        content: json['content'],
        date: json['date'],
        cId: json['cid']);
  }

  Map<String, dynamic> toJson() =>
      {'nickname': nickname, 'content': content, 'date': date, 'cid': cId};
}
