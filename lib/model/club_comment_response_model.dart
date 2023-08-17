class ClubCommentResponse {
  final String content;
  final String nickname;
  final String date;
  final int pId;
  final int cId;
  final int type;

  ClubCommentResponse(
      {required this.content,
      required this.nickname,
      required this.date,
      required this.cId,
      required this.pId,
      required this.type});

  factory ClubCommentResponse.fromJson(Map<String, dynamic> json) {
    return ClubCommentResponse(
        content: json['content'],
        nickname: json['nickname'],
        date: json['date'],
        cId: json['cid'],
        pId: json['cpId'],
        type: json['type']);
  }

  Map<String, dynamic> toJson() => {
        'content': content,
        'nickname': nickname,
        'date': date,
        'cid': cId,
        'cpId': pId,
        'type': type
      };
}
