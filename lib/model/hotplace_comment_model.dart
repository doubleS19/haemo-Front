class HotPlaceComment {
  final String nickname;
  final String content;
  final String date;
  final int pId;
  final int type;

  HotPlaceComment(
      {required this.nickname,
      required this.content,
      required this.date,
      required this.pId,
      required this.type});

  factory HotPlaceComment.fromJson(Map<String, dynamic> json) {
    return HotPlaceComment(
        nickname: json['nickname'],
        content: json['content'],
        date: json['date'],
        type: json['type'],
        pId: json['hpId']);
  }

  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'content': content,
        'date': date,
        'hpId': pId,
        'type': type
      };
}
