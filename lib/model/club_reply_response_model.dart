class ClubReplyResponse {
  final String content;
  final String nickname;
  final String date;
  final int rId;
  final int cId;
  final int type;

  ClubReplyResponse(
      {required this.content,
      required this.nickname,
      required this.date,
      required this.rId,
      required this.cId,
      required this.type});

  factory ClubReplyResponse.fromJson(Map<String, dynamic> json) {
    return ClubReplyResponse(
        content: json['content'],
        nickname: json['nickname'],
        date: json['date'],
        rId: json['crid'],
        cId: json['ccId'],
        type: json['type']);
  }

  Map<String, dynamic> toJson() => {
        'content': content,
        'nickname': nickname,
        'date': date,
        'crid': rId,
        'ccId': cId,
        'type': type
      };
}
