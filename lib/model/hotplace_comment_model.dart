class HotPlaceComment {
  final String nickname;
  final String content;
  final String date;
  final int pId;

  HotPlaceComment(
      {required this.nickname,
      required this.content,
      required this.date,
      required this.pId});

  factory HotPlaceComment.fromJson(Map<String, dynamic> json) {
    return HotPlaceComment(
        nickname: json['nickname'],
        content: json['content'],
        date: json['date'],
        pId: json['hpId']);
  }

  Map<String, dynamic> toJson() =>
      {'nickname': nickname, 'content': content, 'date': date, 'hpId': pId};
}
