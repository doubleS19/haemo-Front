class HotPlaceReplyResponse {
  final String content;
  final String nickname;
  final String date;
  final int cId;
  final int rId;
  final int type;

  HotPlaceReplyResponse(
      {required this.content,
      required this.nickname,
      required this.date,
      required this.cId,
      required this.rId,
      required this.type});

  factory HotPlaceReplyResponse.fromJson(Map<String, dynamic> json) {
    return HotPlaceReplyResponse(
        content: json['content'],
        nickname: json['nickname'],
        date: json['date'],
        rId: json['hrid'],
        cId: json['hcId'],
        type: json['type']);
  }

  Map<String, dynamic> toJson() => {
        'content': content,
        'nickname': nickname,
        'date': date,
        'hrid': rId,
        'hcId': cId,
        'type': type
      };
}
