class HotPlaceReplyResponse {
  final String content;
  final String nickname;
  final String date;
  final int cId;
  final int rId;

  HotPlaceReplyResponse(
      {required this.content,
      required this.nickname,
      required this.date,
      required this.cId,
      required this.rId});

  factory HotPlaceReplyResponse.fromJson(Map<String, dynamic> json) {
    return HotPlaceReplyResponse(
        content: json['content'],
        nickname: json['nickname'],
        date: json['date'],
        rId: json['hrId'],
        cId: json['hcId']);
  }

  Map<String, dynamic> toJson() => {
        'content': content,
        'nickname': nickname,
        'date': date,
        'hrId': rId,
        'hcId': cId
      };
}
