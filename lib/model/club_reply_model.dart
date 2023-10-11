class ClubReply {
  final String nickname;
  final String content;
  final String date;
  final int cId;

  ClubReply(
      {required this.nickname,
      required this.content,
      required this.date,
      required this.cId});

  factory ClubReply.fromJson(Map<String, dynamic> json) {
    return ClubReply(
        nickname: json['nickname'],
        content: json['content'],
        date: json['date'],
        cId: json['ccId']);
  }

  Map<String, dynamic> toJson() =>
      {'nickname': nickname, 'content': content, 'date': date, 'ccId': cId};
}
