class Comment {
  final String nickname;
  final String content;
  final String date;
  final int pId;

  Comment(
      {required this.nickname,
      required this.content,
      required this.date,
      required this.pId});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        nickname: json['nickname'],
        content: json['content'],
        date: json['date'],
        pId: json['pid']);
  }

  Map<String, dynamic> toJson() =>
      {'nickname': nickname, 'content': content, 'date': date, 'pid': pId};
}
