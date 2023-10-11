class ClubCommentResponse {
  final String content;
  final String nickname;
  final String date;
  final int pId;
  final int cId;

  ClubCommentResponse(
      {required this.content,
      required this.nickname,
      required this.date,
      required this.cId,
      required this.pId});

  factory ClubCommentResponse.fromJson(Map<String, dynamic> json) {
    return ClubCommentResponse(
        content: json['content'],
        nickname: json['nickname'],
        date: json['date'],
        cId: json['ccId'],
        pId: json['cpId']);
  }

  Map<String, dynamic> toJson() => {
        'content': content,
        'nickname': nickname,
        'date': date,
        'ccId': cId,
        'cpId': pId
      };
}
