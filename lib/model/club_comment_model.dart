class ClubComment {
  final String nickname;
  final String content;
  final String date;
  final int pId;
  final int type;

  ClubComment(
      {required this.nickname,
      required this.content,
      required this.date,
      required this.pId,
      required this.type});

  factory ClubComment.fromJson(Map<String, dynamic> json) {
    return ClubComment(
        nickname: json['nickname'],
        content: json['content'],
        date: json['date'],
        type: json['type'],
        pId: json['cpId']);
  }

  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'content': content,
        'date': date,
        'cpId': pId,
        'type': type
      };
}
