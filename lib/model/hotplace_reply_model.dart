class HotPlaceReply {
  final String nickname;
  final String content;
  final String date;
  final int cId;

  HotPlaceReply(
      {required this.nickname,
      required this.content,
      required this.date,
      required this.cId});

  factory HotPlaceReply.fromJson(Map<String, dynamic> json) {
    return HotPlaceReply(
        nickname: json['nickname'],
        content: json['content'],
        date: json['date'],
        cId: json['hcId']);
  }

  Map<String, dynamic> toJson() =>
      {'nickname': nickname, 'content': content, 'date': date, 'hcId': cId};
}
