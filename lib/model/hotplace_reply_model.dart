class HotPlaceReply {
  final String nickname;
  final String content;
  final String date;
  final int cId;
  final int type;

  HotPlaceReply(
      {required this.nickname,
      required this.content,
      required this.date,
      required this.cId,
      required this.type});

  factory HotPlaceReply.fromJson(Map<String, dynamic> json) {
    return HotPlaceReply(
        nickname: json['nickname'],
        content: json['content'],
        date: json['date'],
        type: json['type'],
        cId: json['hcId']);
  }

  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'content': content,
        'date': date,
        'hcId': cId,
        'type': type
      };
}
